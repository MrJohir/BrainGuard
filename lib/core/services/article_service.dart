import 'package:http/http.dart' as http;
import 'package:lustless_hichim890/features/motivational_content/model/article_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleService {
  Future<List<ArticleModel>> fetchArticles() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('access_token');

      if (token == null) {
        throw Exception('No access token found');
      }

      final response = await http.get(
        Uri.parse('https://hachim-backend-1.onrender.com/article'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['success'] == true) {
          final List<dynamic> data = jsonData['data'];
          return data.map((item) => ArticleModel.fromJson(item)).toList();
        } else {
          throw Exception('API request failed: ${jsonData['message']}');
        }
      } else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching articles: $e');
    }
  }
}
