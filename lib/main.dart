import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:good_place/config/theme.dart';
import 'package:good_place/core/constants/app_paddings.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/features/notification/notification_service.dart';
import 'package:good_place/features/user_data/habit_provider.dart';
import 'package:good_place/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'config/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final _notificationService = NotificationService();

  await dotenv.load(fileName: ".env");

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    ChangeNotifierProvider(
      create: (_) => HabitProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme().theme,
        routes: AppRoutes().routes,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// After 3 seconds navigate to [AuthManager]
  Future _splashManager() async {
    await Future.delayed(const Duration(seconds: 2));
    context.navigator.pushReplacementNamed("/");
  }

  @override
  void initState() {
    super.initState();
  }

  final Duration _intervalDuration = const Duration(milliseconds: 300);
  final Duration _animationDuration = Durations.medium4;
  @override
  Widget build(BuildContext context) {
    _splashManager();
    return Scaffold(
      backgroundColor: AppColors.welcomeScaffoldColor,
      // appBar: AppBar(
      //   systemOverlayStyle: const SystemUiOverlayStyle(
      //     systemNavigationBarColor: AppColors.welcomeScaffoldColor,
      //   ),
      // ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // const Spacer(
          //   flex: 8,
          // ),
          // Text(
          //   "IT IS A",
          //   style: context.textTheme.titleMedium?.copyWith(
          //     color: AppColors.authScaffoldColor,
          //     fontWeight: FontWeight.normal,
          //   ),
          // ).animate().fadeIn().shimmer(
          //       color: AppColors.succDark,
          //       duration: _animationDuration,
          //     ),
          const Gap(AppPaddings.smallPaddingValue),
          // const Spacer(
          //   flex: 1,
          // ),
          Text.rich(
            TextSpan(
              text: "Good",
              style: context.textTheme.headlineLarge?.copyWith(
                color: AppColors.succDark,
              ),
              children: [
                TextSpan(
                  text: " Place",
                  style: context.textTheme.headlineLarge?.copyWith(
                    color: AppColors.orangeTextColor,
                  ),
                )
              ],
            ),
          )
              .animate(
                delay: _intervalDuration + _animationDuration,
              )
              .fadeIn()
              .shimmer(
                duration: _animationDuration,
                color: AppColors.errLight,
              ),

          // const Spacer(
          //   flex: 1,
          // ),,
          const Gap(AppPaddings.xxsmallPaddingValue),

          // Text(
          //   "to",
          //   style: context.textTheme.titleMedium
          //       ?.copyWith(color: AppColors.authScaffoldColor),
          // )
          //     .animate(
          //       delay: _intervalDuration * 2 + _animationDuration,
          //     )
          //     .fadeIn()
          //     .shimmer(
          //       color: AppColors.darkTextColor,
          //       duration: _animationDuration,
          //     ),
          const Gap(AppPaddings.xxsmallPaddingValue),
          Text(
            "Track Your Habits",
            style: context.textTheme.headlineSmall?.copyWith(
              color: AppColors.authScaffoldColor.withOpacity(0.6),
              fontWeight: FontWeight.bold,
            ),
          )
              .animate(
                delay: _intervalDuration * 3 + _animationDuration,
              )
              .fadeIn()
              .shimmer(
                color: AppColors.grayTextColor,
                duration: _animationDuration,
              ),
          const Gap(AppPaddings.xxsmallPaddingValue),
          // Text(
          //   "Habits",
          //   style: context.textTheme.titleMedium
          //       ?.copyWith(color: AppColors.authScaffoldColor),
          // )
          //     .animate(
          //       delay: _intervalDuration * 4 + _animationDuration,
          //     )
          //     .fadeIn()
          //     .shimmer(
          //       color: AppColors.errDark,
          //       duration: _animationDuration,
          //       // delay: _intervalDuration * 4 + _animationDuration,
          //     ),
          // const Spacer(),
        ]),
      ),
    );
  }
}
