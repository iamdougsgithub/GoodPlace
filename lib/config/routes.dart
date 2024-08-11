import 'package:flutter/material.dart';
import 'package:good_place/features/auth/firebase/auth_manager.dart';

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
    // TODO : AuthManager ile değiştir.
    "/": (_) => const AuthManager(),
    SignInPage.routeName: (_) => SignInPage(),
    SignUpPage.routeName: (_) => SignUpPage(),
    OnboardingPage.routeName: (_) => const OnboardingPage(),
    WelcomePage.routeName: (_) => const WelcomePage(),
  };

  Map<String, Widget Function(BuildContext)> get routes => _routes;
}
