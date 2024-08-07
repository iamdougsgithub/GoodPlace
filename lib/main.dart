import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/constants/app_assets.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/core/resourcers/error_texts.dart';
import 'package:good_place/core/utils/widgets/custom_buttons.dart';
import 'package:good_place/core/utils/widgets/image_container.dart';

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
      extendBody: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          // AssetImageContainer(
          //   path: AppAssets.welcomePageImage,
          //   width: context.dynamicWidth(1),
          //   height: context.dynamicHeight(0.65),
          //   fit: BoxFit.fill,
          // ),
          Row(
            children: [
              ExpandedFilledButtonWithIcon(
                onPressed: () {},
                label: "asd",
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
