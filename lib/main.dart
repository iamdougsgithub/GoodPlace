import 'package:flutter/material.dart';
import 'package:good_place/features/onboarding/onboarding_page.dart';
import 'package:good_place/playground.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:good_place/config/theme.dart';
import 'config/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // bool _isOnboardingCompleted = false;
  // @override
  // void initState() {
  //   super.initState();
  //   _checkOnboardingStatus();
  // }

  // Future<void> _checkOnboardingStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _isOnboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme().theme,
      routes: AppRoutes().routes,
      // home: //const Playground(),
      //     _isOnboardingCompleted ? const Playground() : const OnboardingPage(),
    );
  }
}
