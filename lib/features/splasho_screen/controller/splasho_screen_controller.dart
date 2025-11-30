import 'dart:async';
import 'package:get/get.dart';
import 'package:lustless_hichim890/core/services/storage_service.dart';
import 'package:lustless_hichim890/features/bottom_nav_ber/screen/bottom_navigation_ber.dart';
import 'package:lustless_hichim890/features/onboring_screen/screen/onborging_screen.dart';

class SplashoScreenController extends GetxController {
  final RxBool showFirst = false.obs;
  final RxBool showSecond = false.obs;
  final RxBool showThird = false.obs;

  @override
  void onInit() {
    startTextAnimation();
    navigateAfterDelay();
    super.onInit();
  }

  void startTextAnimation() async {
    await Future.delayed(Duration(milliseconds: 700));
    showFirst.value = true;
    await Future.delayed(Duration(milliseconds: 700));
    showSecond.value = true;
    await Future.delayed(Duration(milliseconds: 700));
    showThird.value = true;
  }

  void navigateAfterDelay() async {
    await Future.delayed(Duration(seconds: 3));
    if (StorageService.hasToken()) {
      Get.offAll(() => BottomNavbar());
    } else {
      Get.offAll(() => OnbordingScreen());
    }
  }
}
