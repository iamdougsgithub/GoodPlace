import 'package:flutter/material.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/features/AI%20chat/pages/ai_chat.dart';
import 'package:good_place/features/chatgpt/ChatGptService.dart';
import 'package:good_place/features/user_data/habit_provider.dart';
import 'package:good_place/features/user_data/user_database_service.dart';
import 'package:provider/provider.dart';

mixin AiChatMixin on State<AIChat> {
  final TextEditingController controller = TextEditingController();
  String allHabitInformationContent = "";

  final List<Map<String, String>> messages = []; //user-ai
  late HabitProvider habitProvider;
  final ChatgptService chatgptService = ChatgptService();
  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() {
    setState(() {
      messages.add({
        'role': 'ai',
        'content':
            'Hello ${UserDatabaseService.userName}!👋 How can I help you?😊😊'
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    habitProvider = Provider.of<HabitProvider>(context);
    allHabitInformationContent = habitProvider.getAllHabitInformation();
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
        setState(() {
          response += word;
          messages[messages.length - 1] = {'role': 'ai', 'content': response};
        });
        context.mediaQuery.removeViewInsets(removeBottom: true);
        scrollController.animateTo(
            scrollController.position.maxScrollExtent +
                kBottomNavigationBarHeight,
            duration: Durations.medium2,
            curve: Curves.linear);
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

  final FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();
}
