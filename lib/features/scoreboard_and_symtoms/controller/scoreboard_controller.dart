import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScoreboardController extends GetxController {
  RxList<int> selectedMentalSection = <int>[].obs;
  RxList<int> selectedPhysicalSection = <int>[].obs;
  RxList<int> selectedSocialSection = <int>[].obs;
  RxList<int> selectedFaithSection = <int>[].obs;

  static const int maxMentalOptions = 4;
  static const int maxPhysicalOptions = 3;
  static const int maxSocialOptions = 4;
  static const int maxFaithOptions = 4;

  void toggleMental(int? value) {
    if (value != null) {
      if (value == -1) {
        selectedMentalSection.assignAll(List.generate(maxMentalOptions, (index) => index + 1));
      } else if (selectedMentalSection.contains(value)) {
        selectedMentalSection.remove(value);
      } else {
        selectedMentalSection.add(value);
      }
    }
  }

  void togglePhysical(int? value) {
    if (value != null) {
      if (value == -1) {
        selectedPhysicalSection.assignAll(List.generate(maxPhysicalOptions, (index) => index + 1));
      } else if (selectedPhysicalSection.contains(value)) {
        selectedPhysicalSection.remove(value);
      } else {
        selectedPhysicalSection.add(value);
      }
    }
  }

  void toggleSocial(int? value) {
    if (value != null) {
      if (value == -1) {
        selectedSocialSection.assignAll(List.generate(maxSocialOptions, (index) => index + 1));
      } else if (selectedSocialSection.contains(value)) {
        selectedSocialSection.remove(value);
      } else {
        selectedSocialSection.add(value);
      }
    }
  }

  void toggleFaith(int? value) {
    if (value != null) {
      if (value == -1) {
        selectedFaithSection.assignAll(List.generate(maxFaithOptions, (index) => index + 1));
      } else if (selectedFaithSection.contains(value)) {
        selectedFaithSection.remove(value);
      } else {
        selectedFaithSection.add(value);
      }
    }
  }

  RxBool selectedValue = false.obs;
  void checkFaith() {
    selectedValue.value = !selectedValue.value;
  }

  RxList<int> selectedGoals = <int>[].obs;

  void toggleGoal(int? value) {
    if (value != null) {
      if (value == -1) {
        selectedGoals.assignAll(List.generate(6, (index) => index + 1));
      } else if (selectedGoals.contains(value)) {
        selectedGoals.remove(value);
        if (selectedGoals.length < 6) {
          selectedGoals.remove(-1);
        }
      } else {
        selectedGoals.add(value);
        if (selectedGoals.length == 6 && !selectedGoals.contains(-1)) {
          selectedGoals.add(-1);
        }
      }
    }
  }

  final PageController controller = PageController();
  var currentPage = 0.obs;
  void goToNextPage() {
    controller.nextPage(
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  final PageController controllerTwo = PageController();
  var currentPageTwo = 0.obs;
  void goToNextPageTwo() {
    controllerTwo.nextPage(
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  void onPageChangedTwo(int index) {
    currentPageTwo.value = index;
  }
}