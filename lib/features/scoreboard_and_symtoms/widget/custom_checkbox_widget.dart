import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lustless_hichim890/core/common/styles/global_text_style.dart';
import 'package:lustless_hichim890/core/utils/constants/colors.dart';
import 'package:lustless_hichim890/features/scoreboard_and_symtoms/controller/scoreboard_controller.dart';

class CustomCheckboxWidget extends StatelessWidget {
  final String text;
  final double fontsize;
  final int value;
  final ScoreboardController scoreboardController;
  final void Function(int? value) onChanged;
  final String section;

  const CustomCheckboxWidget({
    super.key,
    required this.text,
    required this.fontsize,
    required this.value,
    required this.scoreboardController,
    required this.onChanged,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth < 400 ? 17.0 : 18.0;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 58,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.secondary),
      ),
      child: Obx(
        () => Row(
          children: [
            Checkbox(
              value: value == -1 ? _isAllSelected() : _isValueSelected(),
              onChanged: (bool? checked) {
                onChanged(checked == true ? value : null);
              },
              activeColor: AppColors.primaryBackground,
              checkColor: AppColors.primary,
              side: BorderSide(color: AppColors.secondary),
              shape: CircleBorder(),
            ),
            Text(
              text,
              style: getTextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isAllSelected() {
    switch (section) {
      case 'mental':
        return scoreboardController.selectedMentalSection.length ==
            ScoreboardController.maxMentalOptions;
      case 'physical':
        return scoreboardController.selectedPhysicalSection.length ==
            ScoreboardController.maxPhysicalOptions;
      case 'social':
        return scoreboardController.selectedSocialSection.length ==
            ScoreboardController.maxSocialOptions;
      case 'faith':
        return scoreboardController.selectedFaithSection.length ==
            ScoreboardController.maxFaithOptions;
      default:
        return false;
    }
  }

  bool _isValueSelected() {
    switch (section) {
      case 'mental':
        return scoreboardController.selectedMentalSection.contains(value);
      case 'physical':
        return scoreboardController.selectedPhysicalSection.contains(value);
      case 'social':
        return scoreboardController.selectedSocialSection.contains(value);
      case 'faith':
        return scoreboardController.selectedFaithSection.contains(value);
      default:
        return false;
    }
  }
}
