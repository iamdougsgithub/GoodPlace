import 'package:flutter/material.dart';
import 'package:good_place/core/constants/app_paddings.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/features/home/quotable_api_service.dart';
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
                child: Padding(
                  padding: const EdgeInsets.all(AppPaddings.smallPaddingValue),
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
