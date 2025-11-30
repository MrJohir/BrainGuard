import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lustless_hichim890/core/common/widgets/custom_button.dart';
import 'package:lustless_hichim890/core/utils/constants/colors.dart';
import 'package:lustless_hichim890/core/utils/constants/icon_path.dart';
import 'package:lustless_hichim890/core/common/styles/global_text_style.dart';
import 'package:lustless_hichim890/features/bottom_nav_ber/controller/bottom_nav_ber_controller.dart';
import 'package:lustless_hichim890/features/bottom_nav_ber/screen/bottom_navigation_ber.dart';
import 'package:lustless_hichim890/features/journal_screen/api_service/journal_service.dart';
import 'package:lustless_hichim890/features/journal_screen/model/journal_entry_model.dart';
import 'package:lustless_hichim890/features/journal_screen/widget/journel_entry.dart';

class JournalStatusController extends GetxController {
  TextEditingController feelingController = TextEditingController();

  // UI states
  RxBool isMoodSelected = false.obs;
  RxBool isUrgueSelected = false.obs;
  RxBool isEditing = false.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  late FocusNode focusNode;
  late TextEditingController textController;

  // Journal entries
  RxList<JournalEntry> journalEntries = <JournalEntry>[].obs;

  @override
  void onInit() {
    textController = TextEditingController(text: currentMessage.value);
    focusNode = FocusNode();
    textController.addListener(() {
      currentMessage.value = textController.text;
    });
    fetchJournalEntries();
    super.onInit();
  }

  @override
  void onClose() {
    textController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  RxString selectedDate = "Select Date".obs;
  DateTime? _selectedDateTime;

  RxDouble moodSliderValue = 0.5.obs;
  RxString selectedMood = "Happy".obs;
  RxString moodEmoji = "😊".obs;
  RxInt moodValue = 3.obs;

  RxDouble urgeSliderValue = 0.5.obs;
  RxString selectedUrge = "Happy".obs;
  RxString urgeEmoji = "😊".obs;
  RxInt urgeValue = 3.obs;

  RxString currentMessage = ''.obs;

  // Mood List
  final List<Map<String, dynamic>> moodList = [
    {'emoji': '😞', 'label': 'Sad', 'value': 0},
    {'emoji': '😐', 'label': 'Neutral', 'value': 1},
    {'emoji': '🙂', 'label': 'Content', 'value': 2},
    {'emoji': '😊', 'label': 'Happy', 'value': 3},
    {'emoji': '😁', 'label': 'Excited', 'value': 4},
  ];

  String getEmojiForValue(int value) {
    final mood = moodList.firstWhere(
      (mood) => mood['value'] == value,
      orElse: () => {'emoji': '😐', 'label': 'Unknown', 'value': -1},
    );
    return mood['emoji'];
  }

  /// Mood slider update
  void updateMood(double value) {
    moodSliderValue.value = value;
    if (value <= 0.2) {
      selectedMood.value = moodList[0]['label'];
      moodEmoji.value = moodList[0]['emoji'];
      moodValue.value = moodList[0]['value'];
    } else if (value <= 0.4) {
      selectedMood.value = moodList[1]['label'];
      moodEmoji.value = moodList[1]['emoji'];
      moodValue.value = moodList[1]['value'];
    } else if (value <= 0.6) {
      selectedMood.value = moodList[2]['label'];
      moodEmoji.value = moodList[2]['emoji'];
      moodValue.value = moodList[2]['value'];
    } else if (value <= 0.8) {
      selectedMood.value = moodList[3]['label'];
      moodEmoji.value = moodList[3]['emoji'];
      moodValue.value = moodList[3]['value'];
    } else {
      selectedMood.value = moodList[4]['label'];
      moodEmoji.value = moodList[4]['emoji'];
      moodValue.value = moodList[4]['value'];
    }
  }

  /// Urge slider update
  void updateUrge(double value) {
    urgeSliderValue.value = value;
    if (value >= 0.8) {
      selectedUrge.value = moodList[0]['label'];
      urgeEmoji.value = moodList[0]['emoji'];
      urgeValue.value = moodList[0]['value'];
    } else if (value >= 0.6) {
      selectedUrge.value = moodList[1]['label'];
      urgeEmoji.value = moodList[1]['emoji'];
      urgeValue.value = moodList[1]['value'];
    } else if (value >= 0.4) {
      selectedUrge.value = moodList[2]['label'];
      urgeEmoji.value = moodList[2]['emoji'];
      urgeValue.value = moodList[2]['value'];
    } else if (value >= 0.2) {
      selectedUrge.value = moodList[3]['label'];
      urgeEmoji.value = moodList[3]['emoji'];
      urgeValue.value = moodList[3]['value'];
    } else {
      selectedUrge.value = moodList[4]['label'];
      urgeEmoji.value = moodList[4]['emoji'];
      urgeValue.value = moodList[4]['value'];
    }
  }

  /// Toggle mood selected
  void toggleMood() {
    if (isMoodSelected.value) {
      isMoodSelected.value = false;
    } else {
      isMoodSelected.value = true;
      isUrgueSelected.value = false;
    }
  }

  /// Toggle urge selected
  void toggleUrge() {
    if (isUrgueSelected.value) {
      isUrgueSelected.value = false;
    } else {
      isUrgueSelected.value = true;
      isMoodSelected.value = false;
    }
  }

  /// Toggle editing state
  void toggleEditing() {
    isEditing.value = !isEditing.value;
  }

  /// Update message for edit
  void updateMessage(String message) {
    currentMessage.value = message;
  }

  /// Select a date
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      _selectedDateTime = picked;
      selectedDate.value = DateFormat('d MMM yy').format(picked);
    }
  }

  Future<void> fetchJournalEntries() async {
    isLoading.value = true;
    errorMessage.value = '';
    journalEntries.clear(); // Ensure no stale data
    final service = JournalService();
    try {
      final entries = await service.getJournalEntries();
      journalEntries.assignAll(entries);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching journals: $e');
      }
      errorMessage.value = 'Failed to load journals';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createJournal(BuildContext context) async {
    if (_selectedDateTime == null) {
      await EasyLoading.showError('Please select a date');
      return;
    }

    final journalEntry = JournalEntryModel(
      note: feelingController.text,
      date: DateFormat('yyyy-MM-dd').format(_selectedDateTime!),
      mode: moodValue.value,
      urge: urgeValue.value,
    );

    final service = JournalService();

    try {
      final response = await service.createJournalEntry(journalEntry);
      if (kDebugMode) {
        print('Successful journal created: $response');
      }
      await fetchJournalEntries();
      showCongratulationsDialog(context);
    } catch (e) {
      if (kDebugMode) {
        print('Server Error: $e');
      }
      await EasyLoading.showError('Failed to save journal');
    }
  }

  Future<void> deleteJournal(String id, BuildContext context) async {
    final service = JournalService();
    try {
      await service.deleteJournalEntry(id);
      await fetchJournalEntries(); // Refresh the journal list
      await EasyLoading.showSuccess('Journal deleted successfully');
      Get.off(() => BottomNavbar()); // Navigate to home after deletion
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting journal: $e');
      }
      await EasyLoading.showError('Failed to delete journal');
    }
  }

  /// Congrats Dialog
  void showCongratulationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Image.asset(IconPath.closelogo, width: 24, height: 24),
                ),
              ),
              Image.asset(
                IconPath.congratulationslogo,
                width: 100,
                height: 100,
              ),
              SizedBox(height: 20),
              Text(
                "Congratulations!",
                style: getTextStylenunito(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Journaling helps track your progress",
                style: getTextStylenunito(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              CustomButton(
                title: "Continue",
                onPress: () {
                  final BottomNavBerController controller = Get.put(
                    BottomNavBerController(),
                  );
                  controller.changeIndex(0);
                  Get.offAll(() => BottomNavbar());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}