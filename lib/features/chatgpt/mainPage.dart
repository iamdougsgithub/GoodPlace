import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:good_place/core/utils/models/habit_model.dart';
import 'dart:async';
import 'package:good_place/features/chatgpt/ChatGptService.dart';
import 'package:good_place/features/chatgpt/SystemContentTexts.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController motivationController = TextEditingController();

  // Bu fonksiyon, getChatResponse fonksiyonunu kullanarak metin oluşturur ve ilgili TextField'e yazar.
  Future<void> generateResponse(
    String? userContentText,
    String systemContentText,
    TextEditingController controller,
  ) async {
    controller.clear();
    final body = ChatgptService().getApiBody(
        systemContentText: systemContentText, userContentText: userContentText);

    var response = '';
    ChatgptService().getChatResponse(body).listen((word) {
      setState(() {
        response += word;
        controller.text = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Purpose Widget
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Purpose',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: purposeController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your purpose...',
                    ),
                  ),
                  SizedBox(height: 10),
                  //=>>>>>>>>>>>>>>      Purpose  --  AI butonu
                  // TODO : burada title create habit sayfasında girilen değer alınacak.
                  ElevatedButton(
                    onPressed: () {
                      generateResponse("title: Koşmak 🎯",
                          purposeSystemContentText, purposeController);
                    },
                    child: const Text('Generate Purpose'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Motivation Widget
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Motivation',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: motivationController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your motivation...',
                    ),
                  ),
                  SizedBox(height: 10),

                  //=>>>>>>>>>>>>>>      Motivation   --  AI butonu
                  ElevatedButton(
                    onPressed: () {
                      Random random = Random();
                      int index =
                          random.nextInt(motivationSystemContentList.length);

                      //örnek HabitModel nesnesi
                      HabitModel habit = HabitModel(
                        title: "Koşu",
                        createDate: DateTime.now(),
                        purpose: "günde 1 saat koşmak",
                        completionDates: [],
                        streakCount: 0,
                        longestStreak: 0,
                      );
                      print("=>>>>>>>>>>>>>>${habit.toString()}");

                      generateResponse(
                          habit.toString(),
                          motivationSystemContentList[index],
                          motivationController);
                    },
                    child: Text('Generate Motivation'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
