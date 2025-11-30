import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lustless_hichim890/core/common/styles/global_text_style.dart';
import 'package:lustless_hichim890/core/common/widgets/custom_color.dart';
import 'package:lustless_hichim890/core/utils/constants/colors.dart';
import 'package:lustless_hichim890/features/motivational_content/controller/video_controller.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;
  final String title;

  const VideoPlayerScreen({super.key, required this.videoUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    Get.put(VideoController(videoUrl: videoUrl));
    final controller = Get.find<VideoController>();
    return Obx(
      () => Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 62),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(gradient: getContainerGradient()),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        title,
                        style: getTextStylenunito(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textWhite,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const Spacer(),
                controller.isInitialized.value
                    ? GestureDetector(
                        onTap: () {
                          controller.togglePlayPause();
                        },
                        child: AspectRatio(
                          aspectRatio: controller.videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(controller.videoPlayerController),
                        ),
                      )
                    : const CircularProgressIndicator(),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: controller.togglePlayPause,
                        icon: Icon(
                          controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                          color: AppColors.primaryBackground,
                          size: 32,
                        ),
                      ),
                      Expanded(
                        child: VideoProgressIndicator(
                          controller.videoPlayerController,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            playedColor: AppColors.secondary,
                            bufferedColor: Colors.grey,
                            backgroundColor: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        controller.currentPosition.value,
                        style: getTextStylenunito(
                          fontSize: 14,
                          color: AppColors.primaryBackground,
                        ),
                      ),
                      Text(
                        " / ",
                        style: getTextStylenunito(
                          fontSize: 14,
                          color: AppColors.primaryBackground,
                        ),
                      ),
                      Text(
                        controller.totalDuration.value,
                        style: getTextStylenunito(
                          fontSize: 14,
                          color: AppColors.primaryBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}