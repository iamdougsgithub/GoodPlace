import 'package:flutter/material.dart';
import 'package:good_place/features/My%20Habits/pages/my_habits_page.dart';
import 'package:good_place/features/auth/firebase/auth_manager.dart';
import 'package:good_place/features/home/pages/home_page.dart';

import '../features/auth/pages/sign_in_page.dart';
import '../features/auth/pages/sign_up.dart';
import '../features/auth/pages/welcome_page.dart';
import '../features/onboarding/onboarding_page.dart';

///
/// ### Kullanım
///  ```
///  class FooPage extends StatelessWidget{
///   static const routeName = 'foo'
/// }
/// ```
/// ```FooPage.routeName: (_) => FooPage(),```
///
class AppRoutes {
  final Map<String, Widget Function(BuildContext)> _routes = {
    "/": (_) => const AuthManager(),
    SignInPage.routeName: (_) => const SignInPage(),
    SignUpPage.routeName: (_) => const SignUpPage(),
    OnboardingPage.routeName: (_) => const OnboardingPage(),
    WelcomePage.routeName: (_) => const WelcomePage(),
    MyHabitsPage.routeName: (_) => const MyHabitsPage(),
    HomePage.routeName: (_) => const HomePage(),
  };

  Map<String, Widget Function(BuildContext)> get routes => _routes;
}
