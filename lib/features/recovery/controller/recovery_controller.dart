import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class RecoveryController extends GetxController {
  var progress = 0.0.obs;
  var date = 0.obs;
  var targetDate = 'July 10, 2025'.obs;
  var improvedconfidence = 0.0.obs;
  var mentalclarity = 0.0.obs;
  var labido = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecoveryData();
  }

  Future<void> fetchRecoveryData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('access_token');
      final response = await http.get(
        Uri.parse('https://hachim-backend-1.onrender.com/recovery'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        progress.value = (data['recoveryPercentage'] / 100).clamp(0.0, 1.0);
        date.value = data['streakDays'];
       
        targetDate.value = 'July 10, 2025'; 
        improvedconfidence.value = (data['improvedConfidence'] / 100).clamp(0.0, 1.0);
        mentalclarity.value = (data['mentalClarity'] / 100).clamp(0.0, 1.0);
        labido.value = (data['increasedLibido'] / 100).clamp(0.0, 1.0);
      } else if (response.statusCode == 401) {
        Get.snackbar(
          'Authentication Error',
          'Failed to authenticate. Please check your API credentials or login status.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xffFF4C4C),
          colorText: Color(0xffFFFFFF),
          duration: Duration(seconds: 5),
        );
      } else {
        // Get.snackbar(
        //   'Error',
        //   'Failed to fetch recovery data: ${response.statusCode}',
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Color(0xffFF4C4C),
        //   colorText: Color(0xffFFFFFF),
        // );
        if (kDebugMode) {
          print('Failed to fetch recovery data: ${response.statusCode}');
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0xffFF4C4C),
        colorText: Color(0xffFFFFFF),
      );
    }
  }

  void updateProgress(double newProgress) {
    progress.value = newProgress.clamp(0.0, 1.0);
  }

  void updateDate(int newDate) {
    date.value = newDate;
  }

  void updateTargetDate(String newTargetDate) {
    targetDate.value = newTargetDate;
  }
}