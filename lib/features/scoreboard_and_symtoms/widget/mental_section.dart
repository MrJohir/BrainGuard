import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lustless_hichim890/core/common/styles/global_text_style.dart';
import 'package:lustless_hichim890/core/utils/constants/colors.dart';
import 'package:lustless_hichim890/features/scoreboard_and_symtoms/controller/field_controller.dart';
import 'package:lustless_hichim890/features/scoreboard_and_symtoms/controller/scoreboard_controller.dart';
import 'package:lustless_hichim890/features/scoreboard_and_symtoms/widget/custom_checkbox_widget.dart';

class MentalSection extends StatelessWidget {
  const MentalSection({super.key, required this.fontSize});
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final ScoreboardController scoreboardController = Get.find<ScoreboardController>();
    final FieldController fieldController = Get.find<FieldController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mental',
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryBackground,
          ),
        ),
        SizedBox(height: 15),
        CustomCheckboxWidget(
          text: 'Feeling unmotivated',
          value: 1,
          scoreboardController: scoreboardController,
          section: 'mental',
          onChanged: (int? value) {
            scoreboardController.toggleMental(value);
            fieldController.validateMentalSection();
          }, fontsize: fontSize,
        ),
        CustomCheckboxWidget(
          text: 'Lack of ambition to pursue goals',
          fontsize: fontSize,
          value: 2,
          scoreboardController: scoreboardController,
          section: 'mental',
          onChanged: (int? value) {
            scoreboardController.toggleMental(value);
            fieldController.validateMentalSection();
          },
        ),
        CustomCheckboxWidget(
          text: 'Difficulty concentrating',
          fontsize: fontSize,
          value: 3,
          scoreboardController: scoreboardController,
          section: 'mental',
          onChanged: (int? value) {
            scoreboardController.toggleMental(value);
            fieldController.validateMentalSection();
          },
        ),
        CustomCheckboxWidget(
          text: "Poor memory or 'brain fog'",
          fontsize: fontSize,
          value: 4,
          scoreboardController: scoreboardController,
          section: 'mental',
          onChanged: (int? value) {
            scoreboardController.toggleMental(value);
            fieldController.validateMentalSection();
          },
        ),
        CustomCheckboxWidget(
          text: "All of the above",
          fontsize: fontSize,
          value: -1,
          scoreboardController: scoreboardController,
          section: 'mental',
          onChanged: (int? value) {
            scoreboardController.toggleMental(value);
            fieldController.validateMentalSection();
          },
        ),
      ],
    );
  }
}