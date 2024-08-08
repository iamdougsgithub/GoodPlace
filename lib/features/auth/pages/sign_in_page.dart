import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/widgets/custom_buttons.dart';
import '../../../core/utils/widgets/custom_text_form_field.dart';
import '../widgets/google_button.dart';
import 'auth_base_view.dart';

class SignInPage extends StatelessWidget {
  static const routeName = "sign-in";

  SignInPage({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final String title = "Welcome Back";
  final String orLoginWithEmail = "OR LOG IN WITH EMAIL";
  final String buttonLabel = "LOG IN";
  final String forgotPassword = "Forgot Password";
  final String dontHaveAnAccount = 'DON’T HAVE AN ACCOUNT? ';
  final String signUp = 'SIGN UP';
  @override
  Widget build(BuildContext context) {
    return AuthBaseView(
      title: title,
      child: Column(
        children: [
          // Google Button
          // TODO: Google button logic ekle.
          const GoogleButton(),
          const Gap(AppPaddings.largePaddingValue),
          // log in with email text
          Text(orLoginWithEmail),
          const Gap(AppPaddings.largePaddingValue),
          // form
          Form(
            key: formKey,
            child: Column(
              children: [
                // email field
                EmailField(),
                const Gap(AppPaddings.smallPaddingValue),
                // Password Field
                PasswordField(),
              ],
            ),
          ),
          const Gap(AppPaddings.mediumPaddingValue),
          // button
          Row(
            children: [
              ExpandedFilledButton(
                label: buttonLabel,
                onPressed: () {},
              ),
            ],
          ),
          //Forgot Password
          Column(
            children: [
              const Gap(AppPaddings.smallPaddingValue),
              TextButton(
                onPressed: () {},
                child: Text(forgotPassword),
              ),
            ],
          ),
          Gap(
            context.dynamicHeight(0.14),
          ),
          //DON’T HAVE AN ACCOUNT?
          Text.rich(
            TextSpan(
              text: dontHaveAnAccount,
              children: [
                TextSpan(
                  text: signUp,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print('SIGN UP tapped');
                    },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
