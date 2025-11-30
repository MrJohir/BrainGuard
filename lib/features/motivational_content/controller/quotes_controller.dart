
import 'package:get/get.dart';
import 'package:lustless_hichim890/core/services/quotes_service.dart';
import 'package:lustless_hichim890/features/motivational_content/model/quote_model.dart';

class QuotesController extends GetxController {
  var quotes = <Quote>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuotes();
  }

  void fetchQuotes() async {
    try {
      isLoading(true);
      final quotesService = QuotesService();
      final fetchedQuotes = await quotesService.fetchQuotes();
      quotes.assignAll(fetchedQuotes);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load quotes: $e');
    } finally {
      isLoading(false);
    }
  }
}