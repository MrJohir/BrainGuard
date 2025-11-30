import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lustless_hichim890/services/api_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});

  Map<String, dynamic> toJson() => {'text': text, 'isUser': isUser};

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(text: json['text'], isUser: json['isUser']);
  }
}

class CoachController extends GetxController {
  final String apiKey = aiApiKey;
  final String apiUrl = aiApiUrl;
  final int maxMessageLength = 1000; 
  final int maxMessagesInContext = 10; 

  var messageController = TextEditingController();
  var messages = <Message>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  void sendMessage() async {
    final userInput = messageController.text.trim();
    if (userInput.isEmpty) {
      Get.snackbar('Error', 'Message cannot be empty',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (userInput.length > maxMessageLength) {
      Get.snackbar('Error', 'Message is too long',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    var userMessage = Message(text: userInput, isUser: true);
    messages.add(userMessage);
    messageController.clear();
    await saveMessages();

    var aiResponse = await fetchAIResponse(userMessage.text);
    if (aiResponse.isNotEmpty) {
      messages.add(Message(text: aiResponse, isUser: false));
      await saveMessages();
    } else {
      Get.snackbar('Error', 'Failed to get AI response',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<String> fetchAIResponse(String userInput) async {
    try {
      final conversationHistory = messages
          .asMap()
          .entries
          .skip(messages.length > maxMessagesInContext
              ? messages.length - maxMessagesInContext
              : 0)
          .map((entry) => {
                'role': entry.value.isUser ? 'user' : 'assistant',
                'content': entry.value.text,
              })
          .toList();
      final requestMessages = [
        {'role': 'system', 'content': 'You are an AI coach helping users overcome challenges, providing empathetic, actionable advice.'},
        ...conversationHistory,
        {'role': 'user', 'content': userInput},
      ];

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': requestMessages,
          'max_tokens': 500, 
          'temperature': 0.7, 
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['choices'][0]['message']['content'].trim();
      } else if (response.statusCode == 429) {
        return "Rate limit exceeded. Please try again later.";
      } else if (response.statusCode == 401) {
        return "Invalid API key. Please contact support.";
      } else {
        return "Error: ${response.reasonPhrase} (Status: ${response.statusCode})";
      }
    } catch (e) {
      return "Failed to connect to AI. Please check your internet connection.";
    }
  }

  Future<void> saveMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encodedData = messages.map((msg) => json.encode(msg.toJson())).toList();
      await prefs.setStringList('chat_messages', encodedData);
    } catch (e) {
      Get.snackbar('Error', 'Failed to save messages',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> loadMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encodedData = prefs.getStringList('chat_messages') ?? [];
      messages.assignAll(
        encodedData.map((msg) => Message.fromJson(json.decode(msg))).toList(),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load messages',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}