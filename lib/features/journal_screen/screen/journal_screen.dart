import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lustless_hichim890/core/common/styles/global_text_style.dart';
import 'package:lustless_hichim890/core/common/widgets/custom_color.dart';
import 'package:lustless_hichim890/core/utils/constants/colors.dart';
import 'package:lustless_hichim890/core/utils/constants/icon_path.dart';
import 'package:lustless_hichim890/features/journal_screen/controller/journal_status_controller.dart';
import 'package:lustless_hichim890/features/journal_screen/screen/jurnal_save_confirmation.dart';
import 'package:lustless_hichim890/features/journal_screen/screen/jurnal_status_screen.dart';
import 'package:shimmer/shimmer.dart';

class JournalScreen extends StatelessWidget {
  JournalScreen({super.key});

  final JournalStatusController controller = Get.put(JournalStatusController());

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 70),
          decoration: BoxDecoration(gradient: getContainerGradient()),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 24),
                  ),
                  Spacer(),
                  Text(
                    "Journal",
                    style: getTextStylenunito(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textWhite,
                    ),
                  ),
                  Spacer(),
                  SizedBox(width: 48),
                ],
              ),
              SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 7,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 7,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 10,
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.secondary),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  child: Container(
                                    width: 200,
                                    height: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        width: double.infinity,
                                        height: 16,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  if (controller.errorMessage.value.isNotEmpty) {
                    return Center(
                      child: Text(
                        controller.errorMessage.value,
                        style: getTextStylenunito(
                          fontSize: 16,
                          color: AppColors.textWhite,
                        ),
                      ),
                    );
                  }
                  if (controller.journalEntries.isEmpty) {
                    return Center(
                      child: Text(
                        'No journals found',
                        style: getTextStylenunito(
                          fontSize: 16,
                          color: AppColors.textWhite,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.journalEntries.length,
                    itemBuilder: (context, index) {
                      final entry = controller.journalEntries[index];
                      final dateParts = entry.formattedDate.split(' ');
                      final day = dateParts.isNotEmpty ? dateParts[0] : '';
                      final month = dateParts.length > 1 ? dateParts[1] : '';
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15, right: 5),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              JurnalSaveConfirmation(
                                id: entry.id,
                                time: entry.formattedTime,
                                message: entry.note,
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 1,
                                color: AppColors.secondary,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.17,
                                    child: Text(
                                      '$day\n$month',
                                      style: getTextStylenunito(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textWhite,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    width: screenWidth * 0.68,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.secondary,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              entry.formattedTime,
                                              style: getTextStylenunito(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.textWhite,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              controller.getEmojiForValue(
                                                entry.mode,
                                              ),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              controller.getEmojiForValue(
                                                entry.urge,
                                              ),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          entry.note,
                                          style: getTextStylenunito(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textWhite,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              SizedBox(height: 70), 
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.to(JurnalStatusScreen());
        },
        child: Image.asset(
          IconPath.journallogo,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}