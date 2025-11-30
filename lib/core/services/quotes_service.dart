import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:lustless_hichim890/features/motivational_content/model/quote_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuotesService {
  Future<List<Quote>> fetchQuotes() async {
    const String apiUrl = 'https://hachim-backend-1.onrender.com/quote';
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access_token');
    const int maxRetries = 3;
    const Duration timeout = Duration(minutes: 1);

    if (token == null) {
      debugPrint('No token found in StorageService');
      throw Exception('No authentication token available');
    }

    for (var attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        final response = await http
            .get(Uri.parse(apiUrl), headers: {'Authorization': 'Bearer $token'})
            .timeout(
              timeout,
              onTimeout: () {
                throw Exception(
                  'Request timed out after ${timeout.inSeconds} seconds',
                );
              },
            );

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonResponse;
          try {
            jsonResponse = convert.jsonDecode(response.body);
          } catch (e) {
            debugPrint(
              'JSON decode error: $e, Response body: ${response.body}',
            );
            throw Exception('Invalid JSON response');
          }

          if (!jsonResponse.containsKey('data') ||
              jsonResponse['data'] is! List) {
            debugPrint('Invalid response format: ${response.body}');
            throw Exception('Response does not contain a valid "data" list');
          }

          final List<dynamic> data = jsonResponse['data'];
          return data.map((json) => Quote.fromJson(json)).toList();
        } else {
          debugPrint(
            'API error: Status ${response.statusCode}, Body: ${response.body}',
          );
          throw Exception('API returned status code ${response.statusCode}');
        }
      } catch (e) {
        if (attempt == maxRetries) {
          debugPrint('Failed after $maxRetries attempts: $e');
          throw Exception('Failed to load quotes: $e');
        }
        await Future.delayed(Duration(seconds: attempt * 2));
      }
    }
    throw Exception('Unexpected error after retries');
  }
}
