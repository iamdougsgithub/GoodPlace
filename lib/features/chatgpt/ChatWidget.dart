import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:good_place/features/chatgpt/ChatGptService.dart';
import 'package:good_place/features/user_data/habit_provider.dart';
import 'package:good_place/features/user_data/user_database_service.dart';
import 'package:good_place/firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");

  runApp(ChangeNotifierProvider(
    create: (_) => HabitProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat Bot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  String allHabitInformatinContent = "";

  List<Map<String, String>> _messages = []; //user-ai
  late HabitProvider habitProvider;
  ChatgptService _chatgptService = ChatgptService();

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() {
    setState(() {
      _messages.add({
        'role': 'ai',
        'content':
            'Merhaba ${UserDatabaseService.userName}!👋 Sana nasıl yardımcı olabilirim?😊😊'
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    habitProvider = Provider.of<HabitProvider>(context);
    allHabitInformatinContent = habitProvider.getAllHabitInformation();
    print("allHabitInformatinContent : $allHabitInformatinContent");
  }

// mesaj gönderme butonuna tıklanınca çalışan method
  void _sendMessage() {
    final userMessage = _controller.text;
    _controller.clear();

    if (userMessage.isNotEmpty) {
      setState(() {
        _messages.add({'role': 'user', 'content': '$userMessage'});

        _messages.add({'role': 'ai'}); // response henüz gelmedi
      });

      final body = _chatgptService.getApiBody(
          systemContentText:
              "Sen alışkanlık asistanısın.Sadece bunla ilgili şeylere cevap verirsin.",
          userContentText: getMessageHistory() + userMessage);

      var response = '';
      _chatgptService.getChatResponse(body).listen((word) {
        setState(() {
          response += word;
          _messages[_messages.length - 1] = {
            'role': 'ai',
            'content': '$response'
          };
        });
      });
    }
  }

  String getMessageHistory() {
    String contextHistory = allHabitInformatinContent;
    for (var message in _messages) {
      contextHistory += "\n${message['role']}: ${message['content']}";
    }
    return contextHistory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat with Bot',
        ),
      ),
      body: Column(
        children: [
          _buildMessages(),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessages() {
    return Expanded(
        child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              final isUserMessage = message['role'] == 'user';

              return ListTile(
                title: Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: isUserMessage ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      message['content'] ?? '',
                      style: TextStyle(
                        color: isUserMessage ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            }));
  }

  Widget _buildUserInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type your message here...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
