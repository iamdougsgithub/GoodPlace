import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_place/config/theme.dart';
import 'package:good_place/features/user_data/habit_provider.dart';
import 'package:good_place/firebase_options.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'config/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  /* MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HabitProvider()),
      ],*/

  runApp(
    ChangeNotifierProvider(
      create: (_) => HabitProvider(),
      child: deneme(),
    ),
  );
}

class deneme extends StatelessWidget {
  const deneme({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Lottie Animation')),
        body: Center(
          child: Lottie.asset('lib/assets/animation.json'),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme().theme,
        routes: AppRoutes().routes,
      ),
    );
  }
}
