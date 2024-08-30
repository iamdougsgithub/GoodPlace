import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/config/theme.dart';
import 'package:good_place/core/constants/app_border_radius.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/features/AI%20chat/pages/ai_chat.dart';
import 'package:good_place/features/AI%20chat/widgets/ai_chat_send_button.dart';
import 'package:good_place/features/chatgpt/ChatGptService.dart';
import 'package:good_place/features/user_data/habit_provider.dart';
import 'package:good_place/features/user_data/user_database_service.dart';
import 'package:good_place/logger.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_paddings.dart';

mixin AiChatMixin on State<AIChat> {
  /// Controllers
  final TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  /// Variables
  String allHabitInformationContent = "";
  final List<Map<String, String>> messages = []; //user-ai
  late HabitProvider habitProvider;
  final ChatgptService chatgptService = ChatgptService();

  ///Lifecycle Functions
  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    habitProvider = Provider.of<HabitProvider>(context);
    allHabitInformationContent = habitProvider.getAllHabitInformation();
  }

  @override
  void dispose() {
    controller.removeListener(() {});
    controller.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  /// Functions
  void _initializeChat() {
    setState(() {
      messages.add({
        'role': 'ai',
        'content':
            'Hello ${UserDatabaseService.userName}!👋 How can I help you?😊😊'
      });
    });
  }

// mesaj gönderme butonuna tıklanınca çalışan method
  void sendMessage() {
    final userMessage = controller.text;
    focusNode.unfocus();

    controller.clear();

    if (userMessage.isNotEmpty) {
      setState(() {
        messages.add({'role': 'user', 'content': userMessage});

        messages.add({'role': 'ai'}); // response henüz gelmedi
      });

      final body = chatgptService.getApiBody(
          systemContentText:
              "Sen alışkanlık asistanısın.Sadece bunla ilgili şeylere cevap verirsin. Ve ingilizce konuş",
          userContentText: getMessageHistory() + userMessage);

      var response = '';
      chatgptService.getChatResponse(body).listen((word) {
        // context.mediaQuery.removeViewInsets(removeBottom: true);
        scrollController.animateTo(
            scrollController.position.maxScrollExtent +
                kBottomNavigationBarHeight * 2,
            duration: Durations.medium4,
            curve: Curves.linear);
        setState(() {
          response += word;
          messages[messages.length - 1] = {'role': 'ai', 'content': response};
        });
      });
    }
  }

  String getMessageHistory() {
    String contextHistory = allHabitInformationContent;
    for (var message in messages) {
      contextHistory += "\n${message['role']}: ${message['content']}";
    }
    return contextHistory;
  }

  /// Widget Functions
  Widget bottomSection() {
    controller.addListener(() {
      setState(() {});
    });
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPaddings.xxsmallPaddingValue * 2),
      // color: AppColors.authScaffoldColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                chipButton(
                  label: "Recommend me a habit.",
                ),
                const Gap(AppPaddings.smallPaddingValue),
                chipButton(
                  label: "I need some help about my habits",
                ),
              ],
            ),
          ),
          Row(
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
        ],
      ),
    );
  }

  InkWell chipButton({
    required String label,
  }) {
    return InkWell(
      borderRadius:
          BorderRadius.circular(AppBorderRadius.smallBorderRadiusValue),
      onTap: () {
        controller.text = label;
        sendMessage();
      },
      child: Chip(
        side: BorderSide.none,
        label: Text(label),
      ),
    );
  }
}
