import 'package:get/get.dart';
import 'package:lustless_hichim890/core/services/video_service.dart';
import 'package:lustless_hichim890/features/motivational_content/model/video_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoScreenController extends GetxController {
  final videos = <VideoModel>[].obs;
  final isLoading = true.obs;
  final errorMessage = ''.obs;
  final isAuthenticated = false.obs;
  final VideoService videoService = VideoService();

  @override
  void onInit() {
    super.onInit();
    checkTokenAndFetchVideos();
  }

  Future<void> checkTokenAndFetchVideos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('access_token');
      if (token != null) {
        isAuthenticated.value = true;
        await fetchVideos();
      } else {
        isAuthenticated.value = false;
        isLoading.value = false;
        errorMessage.value = 'Please log in to view videos';
      }
    } catch (e) {
      isAuthenticated.value = false;
      isLoading.value = false;
      errorMessage.value = 'Error checking authentication: $e';
    }
  }

  Future<void> fetchVideos() async {
    try {
      isLoading.value = true;
      final fetchedVideos = await videoService.fetchVideos();
      videos.assignAll(fetchedVideos);
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}