// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
import 'package:good_place/features/AI%20chat/mixins/ai_chat_mixin.dart';

import 'package:good_place/core/constants/app_paddings.dart';
import 'package:good_place/core/extensions/context_extension.dart';

import '../../../config/theme.dart';
import '../widgets/ai_chat_send_button.dart';

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
        floatingActionButton: textField(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Column(
          children: [
            Flexible(
              child: Padding(
                padding: AppPaddings.authScreenHorizontalPadding,
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
            const Gap(
              kBottomNavigationBarHeight,
            ),
          ],
        ),
      ),
    );
  }

  Widget textField() {
    controller.addListener(() {
      setState(() {});
    });
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPaddings.xxsmallPaddingValue * 2),
      color: AppColors.authScaffoldColor,
      child: Row(
        children: [
          Flexible(
            child: TextField(
              autofocus: true,
              focusNode: focusNode,
              controller: controller,
              keyboardType: TextInputType.text,
              minLines: null,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  constraints: BoxConstraints(
                maxHeight: context.dynamicHeight(0.2),
              )),
            ),
          ),
          const Gap(AppPaddings.xxsmallPaddingValue),
          AIChatSendButton(
            onTap: controller.text.isNotEmpty ? sendMessage : null,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.removeListener(() {});
    controller.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}

class _UserMessageBox extends StatelessWidget {
  const _UserMessageBox({required this.message});

  final String message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPaddings.smallPaddingValue),
      child: Wrap(
        alignment: WrapAlignment.end,
        children: [
          Card(
            color: AppColors.primaryButtonColor,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPaddings.smallPaddingValue),
      child: Wrap(
        children: [
          Card(
            color: AppColors.orangeTextColor,
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
    );
  }
}
