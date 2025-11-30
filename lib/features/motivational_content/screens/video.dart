import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lustless_hichim890/features/motivational_content/controller/video_screen_controller.dart';
import 'package:lustless_hichim890/core/common/styles/global_text_style.dart';
import 'package:lustless_hichim890/core/common/widgets/custom_color.dart';
import 'package:lustless_hichim890/core/utils/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lustless_hichim890/features/motivational_content/widget/video_player.dart';
import 'package:shimmer/shimmer.dart';

class Video extends StatelessWidget {
  const Video({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VideoScreenController());

    return GetBuilder<VideoScreenController>(
      builder: (controller) => Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 62),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(gradient: getContainerGradient()),
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Column(
              children: [
                Row(
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
                    const Spacer(),
                    Text(
                      "Video",
                      style: getTextStylenunito(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textWhite,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
                Expanded(
                  child: Obx(
                    () => controller.isLoading.value
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: GridView.builder(
                              itemCount: 10,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 1.1,
                              ),
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: AppColors.secondary,
                                          ),
                                          color: Colors.white,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 8,
                                        left: 8,
                                        right: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Container(
                                            height: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const Center(
                                        child: Icon(
                                          Icons.play_circle_fill,
                                          size: 50,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : controller.errorMessage.value.isNotEmpty
                            ? Center(
                                child: Text(controller.errorMessage.value),
                              )
                            : controller.isAuthenticated.value
                                ? controller.videos.isEmpty
                                    ? const Center(
                                        child: Text('No videos available'),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: GridView.builder(
                                          itemCount: controller.videos.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 12,
                                            crossAxisSpacing: 12,
                                            childAspectRatio: 1.1,
                                          ),
                                          itemBuilder: (context, index) {
                                            final video = controller.videos[index];
                                            return GestureDetector(
                                              onTap: () {
                                                Get.to(
                                                  () => VideoPlayerScreen(
                                                    videoUrl: video.videoUrl,
                                                    title: video.title,
                                                  ),
                                                );
                                              },
                                              child: Stack(
                                                fit: StackFit.expand,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8,
                                                      ),
                                                      border: Border.all(
                                                        color: AppColors.secondary,
                                                      ),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8,
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            'https://images.unsplash.com/photo-1604079621761-290ee87dbf29?crop=entropy&cs=tinysrgb&fit=max&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDYxfHxsaWZlfGVufDB8fHx8fDE2Njg2OTcwMTI&ixlib=rb-1.2.1&q=80&w=400',
                                                        fit: BoxFit.cover,
                                                        placeholder: (
                                                          context,
                                                          url,
                                                        ) =>
                                                            const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                        errorWidget: (
                                                          context,
                                                          url,
                                                          error,
                                                        ) =>
                                                            const Icon(
                                                          Icons.error,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 8,
                                                    left: 8,
                                                    right: 8,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.6),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                          4,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        video.title,
                                                        style: getTextStylenunito(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              AppColors.textWhite,
                                                        ),
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  const Center(
                                                    child: Icon(
                                                      Icons.play_circle_fill,
                                                      size: 50,
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                : const Center(
                                    child: Text('Please log in to view videos'),
                                  ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}