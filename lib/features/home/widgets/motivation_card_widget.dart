import 'dart:math';

import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/widgets/image_container.dart';
import '../../../core/constants/app_border_radius.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../quotable_api_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MotivationCardWidget extends StatelessWidget {
  const MotivationCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService().getRandomQuote(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: double.infinity,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: AppBorderRadius.smallBorderRadius,
                ),
                child: Stack(
                  children: [
                    /// Background image
                    Positioned(
                      top: 0,
                      left: 0,
                      child: AssetImageContainer(
                        path: AppAssets.motivationCardBgImage,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Transform.rotate(
                        angle: pi,
                        child: AssetImageContainer(
                          path: AppAssets.motivationCardBgImage,
                        ),
                      ),
                    ),

                    /// content
                    Padding(
                      padding:
                          const EdgeInsets.all(AppPaddings.smallPaddingValue),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Content
                          Text(
                            snapshot.data!.content,
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          /// Author
                          Text(
                            "- ${snapshot.data!.author}",
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const _SkeletonMotivationCard();
        });
  }
}

class _SkeletonMotivationCard extends StatelessWidget {
  const _SkeletonMotivationCard();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        child: ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppPaddings.smallPaddingValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "There is only one way to happiness and that is to  cease worrying  about things  which are beyond the power of our will.",
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "- ",
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
