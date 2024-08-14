import 'dart:math';

import 'package:flutter/material.dart';
import '../../../core/utils/widgets/skeleton.dart';
import '../quote_model.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/widgets/image_container.dart';
import '../../../core/constants/app_border_radius.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../quotable_api_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MotivationCardWidget extends StatelessWidget {
  /// Bu widget bir [FutureBuilder] içerisinde APICall yapıyor .
  ///  APICall tamamlanana kadar [_SkeletonMotivationCard] gösteriyor.
  /// APICall tamamlandıgında ise [_MotivationCard]'ı gösteriyor.
  const MotivationCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService().getRandomQuote(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SkeletonWidget(_MotivationCard(_MockQuote.quote));
          }

          /// if data received show MotivationCard
          if (snapshot.hasData) {
            return _MotivationCard(snapshot.data!);
          }

          /// Eğerki [Quote] null gelirse [_MockQuote]'u göster.
          return _MotivationCard(_MockQuote.quote);
        });
  }
}

class _MotivationCard extends StatelessWidget {
  final Quote quote;
  const _MotivationCard(this.quote);

  @override
  Widget build(BuildContext context) {
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
            ..._backgroundImage(),

            /// content
            Padding(
              padding: const EdgeInsets.all(AppPaddings.smallPaddingValue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Content
                  Text(
                    quote.content,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  /// Author
                  Text(
                    "- ${quote.author}",
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

  List<Positioned> _backgroundImage() {
    return [
      Positioned(
        top: 4,
        left: 4,
        child: Skeleton.ignore(
          child: AssetImageContainer(
            path: AppAssets.motivationCardBgImage,
          ),
        ),
      ),
      Positioned(
        bottom: 4,
        right: 4,
        child: Skeleton.ignore(
          child: Transform.rotate(
            angle: pi,
            child: AssetImageContainer(
              path: AppAssets.motivationCardBgImage,
            ),
          ),
        ),
      ),
    ];
  }
}

class _MockQuote {
  static Quote quote = Quote(
    id: "id",
    content:
        "You will never be happy if you continue to search for what happiness consists of. You will never live if you are looking for the meaning of life",
    author: "Albert Camus",
    tags: const ["tags"],
    authorSlug: "authorSlug",
    length: 50,
    dateAdded: DateTime.now(),
    dateModified: DateTime.now(),
  );
}
