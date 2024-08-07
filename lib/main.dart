import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/constants/app_assets.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/core/resourcers/error_texts.dart';
import 'package:good_place/core/utils/widgets/custom_buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                ExpandedFilledButton(
                  label: "asd",
                  onPressed: () {},
                ),
              ],
            ),
            const Gap(16),
            Row(
              children: [
                ExpandedOutlinedButton(
                  label: "asd",
                  onPressed: () {},
                ),
              ],
            ),
            const Gap(16),
            Row(
              children: [
                ExpandedOutlinedButtonWithIcon(
                  label: "asd",
                  icon: Icon(Icons.abc),
                  // child: Text("asdasdasdasd"),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
