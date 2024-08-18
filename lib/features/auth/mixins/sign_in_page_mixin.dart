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
  final TextEditingController passwordController = TextEditingController();

  onLoginTapped() async {
    await AuthService().signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    // .then((user) {
    /// Eğer kullanıcı bu işlemi başarıyla gerçekleştirdiyse [AuthManager]'a geri yolla.
    // if (user == true) {
    context.navigator.pushReplacementNamed(HomePage.routeName);
    //}
  }

  void onSignUpTapped(BuildContext context) =>
      context.navigator.pushReplacementNamed(SignUpPage.routeName);
}
