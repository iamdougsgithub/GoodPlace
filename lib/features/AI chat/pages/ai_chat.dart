// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/constants/app_assets.dart';
import 'package:good_place/features/AI%20chat/mixins/ai_chat_mixin.dart';

import 'package:good_place/core/constants/app_paddings.dart';
import 'package:good_place/core/extensions/context_extension.dart';

import '../../../config/theme.dart';

class AIChat extends StatefulWidget {
  const AIChat({super.key});

  @override
  State<AIChat> createState() => _AIChatState();
}

class _AIChatState extends State<AIChat> with AiChatMixin {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.authScaffoldColor,
    ));
    return SizedBox(
      height: context.dynamicHeight(0.9),
      child: Scaffold(
        backgroundColor: AppColors.authScaffoldColor,
        floatingActionButton: bottomSection(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Column(
          children: [
            Flexible(
              child: Padding(
                padding: AppPaddings.authScreenHorizontalPadding +
                    const EdgeInsets.only(top: AppPaddings.smallPaddingValue),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    if (messages[index]["role"] == "ai") {
                      return _AIMessageBox(
                        message: messages[index]["content"] ?? "",
                      );
                    } else {
                      return _UserMessageBox(
                          message: messages[index]["content"] ?? "");
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: kBottomNavigationBarHeight * 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _UserMessageBox extends StatelessWidget {
  const _UserMessageBox({required this.message});

  final String message;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: AppPaddings.smallPaddingValue,
              right: AppPaddings.xxsmallPaddingValue),
          child: Wrap(
            alignment: WrapAlignment.end,
            children: [
              ChatBubble(
                alignment: Alignment.centerRight,
                clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
                backGroundColor: AppColors.primaryButtonColor,
                child: Padding(
                  padding:
                      const EdgeInsets.all(AppPaddings.xxsmallPaddingValue * 3),
                  child: SizedBox(
                    width: context.dynamicWidth(0.5),
                    child: MarkdownBody(
                      data: message,
                      styleSheet: MarkdownStyleSheet(
                        p: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      shrinkWrap: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const CircleAvatar(
          child: Icon(Icons.person),
        ),
      ],
    );
  }
}

class _AIMessageBox extends StatelessWidget {
  final String message;

  const _AIMessageBox({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: AppAssets.aiIcon(96, 96),
        ),
        Padding(
          padding: const EdgeInsets.only(
              bottom: AppPaddings.smallPaddingValue,
              left: AppPaddings.xxsmallPaddingValue),
          child: Wrap(
            children: [
              ChatBubble(
                backGroundColor: AppColors.orangeTextColor,
                clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
                child: Padding(
                  padding:
                      const EdgeInsets.all(AppPaddings.xxsmallPaddingValue * 3),
                  child: SizedBox(
                    width: context.dynamicWidth(0.6),
                    child: MarkdownBody(
                      data: message,
                      styleSheet: MarkdownStyleSheet(
                        p: context.textTheme.bodyMedium?.copyWith(
                            // color: Colors.white,
                            ),
                      ),
                      shrinkWrap: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
