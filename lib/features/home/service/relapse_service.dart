import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lustless_hichim890/features/home/controller/home_controller.dart';
import 'package:lustless_hichim890/features/home/model/relapse_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class RelapseService {
  final HomeController homeController = Get.put(HomeController());
  final String baseUrl = 'https://hachim-backend-1.onrender.com/relapse';

  Future<bool> postRelapse(RelapseRequestModel model) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('access_token');

      if (token == null) {
        await EasyLoading.showError('Please log in to post a reply');
        Get.offNamed('/login');
        return false;
      }

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(model.toJson()),
      );

      if (kDebugMode) {
        print('STATUS CODE: ${response.statusCode}');
        print('RESPONSE BODY: ${response.body}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        await EasyLoading.showSuccess('Data collected');
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final dynamic timeDiff = jsonResponse['data']?['timeDifferent'];
        if (timeDiff != null && (timeDiff is int || timeDiff is double)) {
          final int days = (timeDiff / (1000 * 60 * 60 * 24)).floor();
          homeController.dayValue.value = days;
          if (kDebugMode) {
            print('✅ timeDifferent: $days days');
          }
        } else {
          if (kDebugMode) {
            print('⚠️ Invalid or missing timeDifferent in response');
          }
          await EasyLoading.showError('Invalid time data received');
          return false;
        }
        return true;
      } else {
        await EasyLoading.showError('Failed to post relapse data');
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('EXCEPTION: $e');
      }
      await EasyLoading.showError('Something went wrong');
      return false;
    }
  }
}