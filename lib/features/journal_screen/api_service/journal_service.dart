import 'package:http/http.dart' as http;
import 'package:lustless_hichim890/features/journal_screen/model/journal_entry_model.dart';
import 'package:lustless_hichim890/features/journal_screen/widget/journel_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class JournalService {
  final String _baseUrl = 'https://hachim-backend-1.onrender.com';

  Future<Map<String, dynamic>> createJournalEntry(JournalEntryModel journalEntry) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access_token');
    if (token == null) {
      await EasyLoading.showError('Please log in to post a reply');
      Get.offNamed('/login');
      throw Exception('No access token found');
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/journal/create'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'note': journalEntry.note,
        'date': journalEntry.date,
        'mode': journalEntry.mode,
        'urge': journalEntry.urge,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create journal: ${response.statusCode}');
    }
  }

  Future<List<JournalEntry>> getJournalEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access_token');
    if (token == null) {
      await EasyLoading.showError('Please log in to view journals');
      Get.offNamed('/login');
      throw Exception('No access token found');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/journal'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'] ?? [];
      return data.map((json) => JournalEntry.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch journals: ${response.statusCode}');
    }
  }

  Future<void> deleteJournalEntry(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access_token');
    if (token == null) {
      await EasyLoading.showError('Please log in to delete journal');
      Get.offNamed('/login');
      throw Exception('No access token found');
    }

    final response = await http.delete(
      Uri.parse('$_baseUrl/journal/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete journal: ${response.statusCode}');
    }
  }
}