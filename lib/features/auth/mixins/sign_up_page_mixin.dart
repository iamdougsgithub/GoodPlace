import 'package:flutter/material.dart';
import 'package:good_place/features/auth/firebase/authService.dart';
import 'package:toastification/toastification.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/widgets/custom_toast.dart';
import '../../../logger.dart';

import '../pages/sign_in_page.dart';
import '../pages/sign_up.dart';

mixin SignUpPageMixin on State<SignUpPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool checkBoxValue = false;

  final String title = "Create your account ";

  final String orLogInWithEmail = "OR LOG IN WITH EMAIL";

  final String iHaveRead = "I have read the ";

  final String privacyPolicy = "Privacy Policy";

  final String buttonLabel = "GET STARTED";

  final String alreadyHaveAnAccount = "ALREADY HAVE AN ACCOUNT? ";

  final String signIn = "SIGN IN";

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void onSignInTapped(BuildContext context) =>
      context.navigator.pushReplacementNamed(SignInPage.routeName);

  void onGetStartedTapped() {
    if (mounted) {
      if (formKey.currentState!.validate()) {
        if (checkBoxValue == true) {
          AuthService()
              .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,
          )
              .then((user) {
            /// Eğer kullanıcı bu işlemi başarıyla gerçekleştirdiyse [AuthManager]'a geri yolla.
            if (user != null) {
              context.navigator.pushReplacementNamed("/");
            }
          });
        } else {
          Toast.errToast(
            title: "Please accept Privacy Policy",
          );
        }
      }
    }
  }

  void changeCheckBoxState(bool newVal) {
    checkBoxValue = newVal;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState?.dispose();
  }
}
