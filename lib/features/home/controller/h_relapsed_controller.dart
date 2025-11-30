import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lustless_hichim890/features/home/model/relapse_request_model.dart';
import 'package:lustless_hichim890/features/home/service/relapse_service.dart';

class HRelapsedController extends GetxController {
  var selectedDate = "Select Date".obs;
  var sliderValue = 0.0.obs;
  var sliderValues = 0.0.obs;
  RxBool isBoredomSelected = false.obs;
  RxBool isStressSelected = false.obs;
  RxBool isLonelinessSelected = false.obs;
  RxBool isMoodSelected = false.obs;
  RxBool isFeelSelected = false.obs;
  RxBool isHurtSelected = false.obs;
  RxBool isBitternessSelected = false.obs;

  TextEditingController noteController = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      String formattedDate = DateFormat('MM/dd/yyyy').format(picked);
      selectedDate.value = formattedDate;
    }
  }

  Future<bool> submitRelapse() async {
    try {
      final relapse = RelapseRequestModel(
        mood: sliderValue.value.toInt(),
        urg: sliderValues.value.toInt(),
        triggers: _getSelectedTriggers(),
        note: noteController.text,
        startDate: DateTime.now().subtract(Duration(hours: 2)).toUtc().toIso8601String(),
      );

      final success = await RelapseService().postRelapse(relapse);
      return success;
    } catch (e) {
      return false;
    }
  }

  String _getSelectedTriggers() {
    List<String> triggers = [];
    if (isBoredomSelected.value) triggers.add("Boredom");
    if (isStressSelected.value) triggers.add("Stress");
    if (isLonelinessSelected.value) triggers.add("Loneliness");
    if (isMoodSelected.value) triggers.add("Mood");
    if (isFeelSelected.value) triggers.add("Fear");
    if (isHurtSelected.value) triggers.add("Hurt");
    if (isBitternessSelected.value) triggers.add("Bitterness");
    return triggers.join(", ");
  }
}
