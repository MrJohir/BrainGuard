import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoPlayerController;
  final isPlaying = false.obs;
  final isInitialized = false.obs;
  final currentPosition = '00:00'.obs;
  final totalDuration = '00:00'.obs;

  VideoController({required String videoUrl}) {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
    )..initialize().then((_) {
        isInitialized.value = true;
        _updateDuration();
        videoPlayerController.addListener(_updatePosition);
      }).catchError((error) {
        isInitialized.value = false;
        Get.snackbar('Error', 'Failed to initialize video: $error');
      });
  }

  void togglePlayPause() {
    if (isPlaying.value) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
    isPlaying.value = !isPlaying.value;
  }

  void _updatePosition() {
    final position = videoPlayerController.value.position;
    currentPosition.value = _formatDuration(position);
    update();
  }

  void _updateDuration() {
    final duration = videoPlayerController.value.duration;
    totalDuration.value = _formatDuration(duration);
    update();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void onClose() {
    videoPlayerController.removeListener(_updatePosition);
    videoPlayerController.dispose();
    super.onClose();
  }
}