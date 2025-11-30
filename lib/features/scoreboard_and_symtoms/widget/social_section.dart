import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lustless_hichim890/core/common/styles/global_text_style.dart';
import 'package:lustless_hichim890/core/utils/constants/colors.dart';
import 'package:lustless_hichim890/features/scoreboard_and_symtoms/controller/field_controller.dart';
import 'package:lustless_hichim890/features/scoreboard_and_symtoms/controller/scoreboard_controller.dart';
import 'package:lustless_hichim890/features/scoreboard_and_symtoms/widget/custom_checkbox_widget.dart';

class SocialSection extends StatelessWidget {
  const SocialSection({super.key, required this.fontSize});
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final ScoreboardController scoreboardController = Get.find<ScoreboardController>();
    final FieldController fieldController = Get.find<FieldController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Social',
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryBackground,
          ),
        ),
        SizedBox(height: 15),
        CustomCheckboxWidget(
          text: "Low self-confidence",
          fontsize: fontSize,
          value: 1,
          scoreboardController: scoreboardController,
          section: 'social',
          onChanged: (int? value) {
            scoreboardController.toggleSocial(value);
            fieldController.validateSocialSection();
          },
        ),
        CustomCheckboxWidget(
          text: "Feeling unattractive",
          fontsize: fontSize,
          value: 2,
          scoreboardController: scoreboardController,
          section: 'social',
          onChanged: (int? value) {
            scoreboardController.toggleSocial(value);
            fieldController.validateSocialSection();
          },
        ),
        CustomCheckboxWidget(
          text: "Unsuccessful or unenjoyable sex",
          fontsize: fontSize,
          value: 3,
          scoreboardController: scoreboardController,
          section: 'social',
          onChanged: (int? value) {
            scoreboardController.toggleSocial(value);
            fieldController.validateSocialSection();
          },
        ),
        CustomCheckboxWidget(
          text: "Difficulty in relationships",
          fontsize: fontSize,
          value: 4,
          scoreboardController: scoreboardController,
          section: 'social',
          onChanged: (int? value) {
            scoreboardController.toggleSocial(value);
            fieldController.validateSocialSection();
          },
        ),
        CustomCheckboxWidget(
          text: "All of the above",
          fontsize: fontSize,
          value: -1,
          scoreboardController: scoreboardController,
          section: 'social',
          onChanged: (int? value) {
            scoreboardController.toggleSocial(value);
            fieldController.validateSocialSection();
          },
        ),
      ],
    );
  }
}