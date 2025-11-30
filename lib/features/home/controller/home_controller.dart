import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lustless_hichim890/core/common/styles/global_text_style.dart';
import 'package:lustless_hichim890/core/common/widgets/custom_alignment_widget.dart';
import 'package:lustless_hichim890/core/common/widgets/custom_button.dart';
import 'package:lustless_hichim890/core/common/widgets/custom_color.dart';
import 'package:lustless_hichim890/core/utils/constants/colors.dart';
import 'package:lustless_hichim890/core/utils/constants/icon_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  static const int _initialSeconds = 24 * 60 * 60; // 24 hours in seconds
  var seconds = _initialSeconds.obs; // Timer seconds
  var days = 0.obs; // Counter for completed 24-hour periods
  var motivationText = ''.obs;

  Timer? _timer;

  void startTimer() {
    _timer?.cancel();

    if (seconds.value <= 0) {
      seconds.value = _initialSeconds; // Reset to 24 hours
      days.value++; // Increment days
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        seconds.value = _initialSeconds; // Reset to 24 hours
        days.value++; // Increment days
      }
    });
  }

  void stopTimer() => _timer?.cancel();

  void resetTimer() {
    seconds.value = _initialSeconds;
    days.value = 0; // Reset days
    stopTimer();
  }

  String get formattedTime {
    final total = seconds.value;
    final hours = total ~/ 3600;
    final minutes = (total % 3600) ~/ 60;
    final secs = total % 60;
    return '${hours}hr : ${minutes}m : ${secs}s';
  }

  @override
  void onInit() async {
    super.onInit();
    startTimer();
    await fetchMotivation();
    await fetchSleepData();
    await fetchMoodData();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  TextEditingController insperationController = TextEditingController();
  TextEditingController motivationController = TextEditingController();
  RxInt dayValue = 0.obs;
  RxString timeValue = '00:20:0.1'.obs;
  RxInt progressValue = 60.obs;
  RxDouble progressDecimal = 0.50.obs;
  RxDouble progressDecimalMood = 0.50.obs;
  RxInt hoursLeft = 8.obs;
  RxInt goal = 1.obs;
  var isMotivationSaved = false.obs;

  void updateProgress(int newProgress) {
    progressValue.value = newProgress;
  }

  void toggleMotivationSaved() {
    isMotivationSaved.value = !isMotivationSaved.value;
  }

  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<void> postMotivation(String motivation, String? token) async {
    if (motivation.trim().isEmpty) {
      await EasyLoading.showError('Motivation text cannot be empty');
      return;
    }

    if (token == null || token.isEmpty) {
      await EasyLoading.showError('Please log in to post a motivation');
      await EasyLoading.dismiss();
      Get.offNamed('/login');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://hachim-backend-1.onrender.com/motivation-track'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'motivation': motivation.trim()}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        motivationText.value = motivation.trim();
        toggleMotivationSaved();
        await EasyLoading.showSuccess('Motivation saved successfully');
      } else {
        await EasyLoading.showError(
          'Failed to save motivation: ${response.statusCode} - ${response.body}',
          duration: Duration(seconds: 5),
        );
      }
    } catch (e) {
      await EasyLoading.showError(
        'An error occurred while saving motivation: $e',
        duration: Duration(seconds: 5),
      );
    }
  }

  Future<void> fetchMotivation() async {
    final token = await _getAuthToken();
    if (token == null || token.isEmpty) {
      await EasyLoading.showError('Please log in to fetch motivation');
      await EasyLoading.dismiss();
      Get.offNamed('/login');
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://hachim-backend-1.onrender.com/motivation-track'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['success'] == true && data['data'] != null) {
          final motivationData = data['data'] as Map<String, dynamic>;
          motivationText.value =
              (motivationData['motivation'] as String?) ?? '';
          if (motivationText.value.isNotEmpty) {
            isMotivationSaved.value = true;
          } else {
            isMotivationSaved.value = false;
          }
        } else {
          await EasyLoading.showSuccess('${data['message']}');
        }
      } else {
        await EasyLoading.showError(
          'Failed to fetch motivation: ${response.statusCode}',
        );
      }
    } catch (e) {
      await EasyLoading.showError(
        'An error occurred while fetching motivation: $e',
      );
    }
  }

  Future<void> fetchSleepData() async {
    final token = await _getAuthToken();
    if (token == null || token.isEmpty) {
      await EasyLoading.showError('Please log in to fetch sleep data');
      await EasyLoading.dismiss();
      Get.offNamed('/login');
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://hachim-backend-1.onrender.com/sleep-track'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['success'] == true && data['data'] != null) {
          final sleepData = data['data'] as Map<String, dynamic>;
          final hours = (sleepData['hours'] as int?) ?? 0;
          progressDecimal.value = hours / 100.0;
        } else {
          await EasyLoading.showSuccess('${data['message']}');
        }
      } else {
        await EasyLoading.showError(
          'Failed to fetch sleep data: ${response.statusCode}',
        );
      }
    } catch (e) {
      await EasyLoading.showError(
        'An error occurred while fetching sleep data: $e',
      );
    }
  }

  Future<void> fetchMoodData() async {
    final token = await _getAuthToken();
    if (token == null || token.isEmpty) {
      await EasyLoading.showError('Please log in to fetch mood data');
      await EasyLoading.dismiss();
      Get.offNamed('/login');
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://hachim-backend-1.onrender.com/mood-track'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['success'] == true && data['data'] != null) {
          final moodData = data['data'] as Map<String, dynamic>;
          final value = (moodData['value'] as int?) ?? 0;
          progressDecimalMood.value = value / 10.0;
          await EasyLoading.showSuccess('${data['message']}');
        } else {
          if (kDebugMode) {
            print('No mood data found');
          }
        }
      } else {
        await EasyLoading.showError(
          'Failed to fetch mood data: ${response.statusCode} - ${response.body}',
          duration: Duration(seconds: 5),
        );
      }
    } catch (e) {
      await EasyLoading.showError(
        'An error occurred while fetching mood data: $e',
        duration: Duration(seconds: 5),
      );
    }
  }

  void whatMotivatesYou(BuildContext context, int index) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: getContainerGradient(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      IconPath.closelogo,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                CustomAlignmentWidget(
                  alignment: Alignment.centerLeft,
                  text: 'What Motivates You?',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textWhite,
                ),
                SizedBox(height: 6),
                CustomAlignmentWidget(
                  alignment: Alignment.centerLeft,
                  text:
                      'Having a clear motivation helps you stay focused on your recovery journey. Why do you want to quit porn?',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textWhite,
                ),
                SizedBox(height: 20),
                CustomAlignmentWidget(
                  alignment: Alignment.centerLeft,
                  text: 'Need inspiration?',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textWhite,
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: insperationController,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'For better relationships with my partner',
                    hintStyle: getTextStyle(
                      fontSize: 14,
                      color: AppColors.textWhite,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.secondary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.secondary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: Icon(
                      Icons.lightbulb_outlined,
                      size: 24,
                      color: AppColors.textWhite,
                    ),
                  ),
                  style: getTextStyle(fontSize: 14, color: AppColors.textWhite),
                ),
                SizedBox(height: 16),
                CustomAlignmentWidget(
                  alignment: Alignment.centerLeft,
                  text: "Your Motivation:",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textWhite,
                ),
                SizedBox(height: 27),
                TextFormField(
                  controller: motivationController,
                  maxLines: 15,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Type your motivation here..........',
                    hintStyle: getTextStyle(
                      fontSize: 14,
                      color: AppColors.textWhite,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.secondary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.secondary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: getTextStyle(fontSize: 14, color: AppColors.textWhite),
                ),
                SizedBox(height: 20),
                CustomButton(
                  title: "Save Motivation",
                  onPress: () async {
                    await EasyLoading.show(status: 'Sending...');
                    final prefs = await SharedPreferences.getInstance();
                    final String? token = prefs.getString('access_token');
                    if (token == null) {
                      await EasyLoading.showError(
                        'Please log in to post a motivation',
                      );
                      await EasyLoading.dismiss();
                      Get.offNamed('/login');
                      return;
                    }
                    await postMotivation(motivationController.text, token);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    await EasyLoading.dismiss();
                  },
                ),
                SizedBox(height: 20),
                CustomAlignmentWidget(
                  alignment: Alignment.center,
                  text: "Use current suggestion",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textWhite,
                ),
                SizedBox(height: keyboardHeight > 0 ? keyboardHeight : 40),
              ],
            ),
          ),
        );
      },
    );
  }
}