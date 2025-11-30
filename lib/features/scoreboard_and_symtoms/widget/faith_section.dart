import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lustless_hichim890/core/common/styles/global_text_style.dart';
import 'package:lustless_hichim890/core/utils/constants/colors.dart';
import 'package:lustless_hichim890/features/scoreboard_and_symtoms/controller/field_controller.dart';
import 'package:lustless_hichim890/features/scoreboard_and_symtoms/controller/scoreboard_controller.dart';
import 'package:lustless_hichim890/features/scoreboard_and_symtoms/widget/custom_checkbox_widget.dart';

class FaithSection extends StatelessWidget {
  final double fontSize;

  const FaithSection({super.key, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    final ScoreboardController scoreboardController =
        Get.find<ScoreboardController>();
    final FieldController fieldController = Get.find<FieldController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Faith Symptoms',
          style: getTextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryBackground,
          ),
        ),
        SizedBox(height: 15),
        CustomCheckboxWidget(
          text: "Feeling distant from god",
          fontsize: fontSize,
          value: 1,
          scoreboardController: scoreboardController,
          section: 'faith',
          onChanged: (int? value) {
            scoreboardController.toggleFaith(value);
            fieldController.validateFaithSection();
          },
        ),
      ],
    );
  }
}
