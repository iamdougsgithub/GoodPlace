import 'package:flutter/material.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/features/home/pages/home_page.dart';
import '../firebase/authService.dart';
import '../pages/sign_in_page.dart';
import '../pages/sign_up.dart';

mixin SignInPageMixin on State<SignInPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final String title = "Welcome Back!";

  final String orLoginWithEmail = "OR LOG IN WITH EMAIL";

  final String buttonLabel = "LOG IN";

  final String forgotPassword = "Forgot Password";

  final String dontHaveAnAccount = 'DON’T HAVE AN ACCOUNT? ';

  final String signUp = 'SIGN UP';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordResetController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  onLoginTapped() async {
    try {
      await AuthService()
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .whenComplete(() {
        if (AuthService().currentUser != null) {
          context.pushReplacementNamed(
            HomePage.routeName,
          );
        }
      });
    } catch (e) {}

    // .then(
    //   (_) => Navigator.of(context).popUntil(
    //     (route) => route.isFirst,
    //   ),
    // );
    /* .then((_) async {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });*/
  }

  void onSignUpTapped(BuildContext context) =>
      context.navigator.pushNamed(SignUpPage.routeName);
}
