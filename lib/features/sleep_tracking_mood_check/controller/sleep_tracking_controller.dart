import 'package:get/get.dart';
import 'package:lustless_hichim890/core/utils/constants/image_path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lustless_hichim890/features/home/controller/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SleepTrackingController extends GetxController {
  RxDouble moodValue = 0.0.obs;
  RxDouble sleepValue = 0.0.obs;
  RxList<int> selectedValue = <int>[].obs;

  final List<Map<String, String>> priorities = [
    {'text': 'Travel', 'image': ImagePath.priority1},
    {'text': 'Relax', 'image': ImagePath.priority2},
    {'text': 'Family', 'image': ImagePath.priority3},
    {'text': 'Friend', 'image': ImagePath.priority4},
    {'text': 'Partner', 'image': ImagePath.priority5},
    {'text': 'Learning', 'image': ImagePath.priority6},
    {'text': 'Travel', 'image': ImagePath.priority1},
    {'text': 'Relax', 'image': ImagePath.priority2},
    {'text': 'Family', 'image': ImagePath.priority3},
    {'text': 'Friend', 'image': ImagePath.priority4},
    {'text': 'Partner', 'image': ImagePath.priority5},
    {'text': 'Learning', 'image': ImagePath.priority6},
  ];

  void togglePriority(int index) {
    if (selectedValue.contains(index)) {
      selectedValue.remove(index);
    } else if (selectedValue.length < 3) {
      selectedValue.add(index);
    }
  }

  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  updateMoodValue(double value) {
    moodValue.value = value;
  }

  updateSleepValue(double value) async {
    sleepValue.value = value;
    await postSleepData(value);
  }

  Future<void> postSleepData(double sliderValue) async {
    final token = await _getAuthToken();
    if (token == null || token.isEmpty) {
      await EasyLoading.showError('Please log in to save sleep data');
      await EasyLoading.dismiss();
      Get.offNamed('/login');
      return;
    }
    final hours = (sliderValue * 100).round();
    try {
      final response = await http.post(
        Uri.parse('https://hachim-backend-1.onrender.com/sleep-track'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'hours': hours}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await EasyLoading.showSuccess('Sleep data saved successfully');
        final homeController = Get.find<HomeController>();
        homeController.progressDecimal.value = hours / 100.0;
      } else {
        await EasyLoading.showError(
          'Failed to save sleep data: ${response.statusCode} - ${response.body}',
          duration: Duration(seconds: 5),
        );
      }
    } catch (e) {
      await EasyLoading.showError(
        'An error occurred while saving sleep data: $e',
        duration: Duration(seconds: 5),
      );
    }
  }

  Future<void> postMoodData(double sliderValue) async {
    final token = await _getAuthToken();
    if (token == null || token.isEmpty) {
      await EasyLoading.showError('Please log in to save mood data');
      await EasyLoading.dismiss();
      Get.offNamed('/login');
      return;
    }
    final value = (sliderValue * 10).round(); 
    try {
      final response = await http.post(
        Uri.parse('https://hachim-backend-1.onrender.com/mood-track'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'value': value}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await EasyLoading.showSuccess('Mood data saved successfully');
      } else {
        await EasyLoading.showError(
          'Failed to save mood data: ${response.statusCode} - ${response.body}',
          duration: Duration(seconds: 5),
        );
      }
    } catch (e) {
      await EasyLoading.showError(
        'An error occurred while saving mood data: $e',
        duration: Duration(seconds: 5),
      );
    }
  }

  String getMoodLabel() {
    if (moodValue.value <= 0.5) {
      return 'I Feel\n pretty good';
    } else {
      return 'I Feel\n Super Great';
    }
  }

  String getSleptLabel() {
    if (sleepValue.value <= 0.5) {
      return "Last night's slept\n pretty well";
    } else if (sleepValue.value <= 0.8) {
      return "Last night's i had a\n Very good night";
    } else {
      return '';
    }
  }
}