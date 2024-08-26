import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:good_place/features/chatgpt/ChatGptService.dart';
import 'package:good_place/features/chatgpt/SystemContentTexts.dart';
import 'package:good_place/features/home/quote_model.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/widgets/image_container.dart';
import '../../../core/constants/app_border_radius.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HabitDetailMotivation extends StatefulWidget {
  /// Bu widget bir [FutureBuilder] içerisinde APICall yapıyor .
  ///  APICall tamamlanana kadar [_SkeletonMotivationCard] gösteriyor.
  /// APICall tamamlandıgında ise [_MotivationCard]'ı gösteriyor.
  const HabitDetailMotivation({
    super.key,
    required this.habitDetail,
  });
  final String habitDetail;
  @override
  State<HabitDetailMotivation> createState() => _HabitDetailMotivationState();
}

class _HabitDetailMotivationState extends State<HabitDetailMotivation> {
  final TextEditingController motivationController = TextEditingController();
  String response = "";

  Future<void> generateResponse(
    String userContentText,
    String systemContentText,
    TextEditingController controller,
  ) async {
    controller.clear();

    var response = '';
    ChatgptService()
        .getChatResponse(userContentText, systemContentText)
        .listen((word) {
      setState(() {
        response += word;
        controller.text = response;
      });
    });
  }

  @override
  void didChangeDependencies() {
    Random random = Random();
    int index = random.nextInt(motivationSystemContentList.length);
    generateResponse(
      widget.habitDetail,
      motivationSystemContentList[index],
      motivationController,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _MotivationCard(motivationController);
  }
}

class _MotivationCard extends StatelessWidget {
  final TextEditingController text;
  const _MotivationCard(this.text);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: double.infinity),
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
                  Markdown(
                    data: text.text,
                    shrinkWrap: true,
                  )

                  /// Content
                  // Text(
                  //   text.text,
                  //   style: context.textTheme.bodyLarge?.copyWith(
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
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
