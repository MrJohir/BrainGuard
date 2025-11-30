import 'package:get/get.dart';
import 'package:lustless_hichim890/features/scoreboard_and_symtoms/controller/scoreboard_controller.dart';

class FieldController extends GetxController {
  final ScoreboardController scoreboardController = Get.find<ScoreboardController>();

  var isMentalSectionSelected = false.obs;
  var isPhysicalSectionSelected = false.obs;
  var isSocialSectionSelected = false.obs;
  var isFaithSectionSelected = false.obs;
  var name = ''.obs;
  var age = ''.obs;

  void validateMentalSection() {
    isMentalSectionSelected.value = scoreboardController.selectedMentalSection.isNotEmpty;
  }

  void validatePhysicalSection() {
    isPhysicalSectionSelected.value = scoreboardController.selectedPhysicalSection.isNotEmpty;
  }

  void validateSocialSection() {
    isSocialSectionSelected.value = scoreboardController.selectedSocialSection.isNotEmpty;
  }

  void validateFaithSection() {
    isFaithSectionSelected.value = scoreboardController.selectedFaithSection.isNotEmpty;
  }

  void validateName(String value) {
    name.value = value;
  }

  void validateAge(String value) {
    age.value = value;
  }

  bool canNavigate() {
    return isMentalSectionSelected.value &&
        isPhysicalSectionSelected.value &&
        isSocialSectionSelected.value &&
        isFaithSectionSelected.value;
  }

  bool canStarted() {
    return name.value.trim().isNotEmpty &&
        age.value.trim().isNotEmpty &&
        int.tryParse(age.value) != null &&
        int.parse(age.value) > 0;
  }
}