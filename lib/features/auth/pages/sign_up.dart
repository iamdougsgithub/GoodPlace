import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/widgets/custom_buttons.dart';
import '../../../core/utils/widgets/custom_text_form_field.dart';
import '../widgets/google_button.dart';
import 'auth_base_view.dart';

class SignUpPage extends StatelessWidget {
  static const routeName = "sign-up";
  SignUpPage({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String title = "Create your account ";
  final String orLogInWithEmail = "OR LOG IN WITH EMAIL";
  final String iHaveRead = "I have read the ";
  final String privacyPolicy = "Privacy Policy";
  final String buttonLabel = "GET STARTED";
  final String alreadyHaveAnAccount = "ALREADY HAVE AN ACCOUNT? ";
  final String signIn = "SIGN IN";
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
          Text(orLogInWithEmail),
          const Gap(AppPaddings.largePaddingValue),
          // form
          Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // name field
                NormalTextFormField(),
                const Gap(AppPaddings.smallPaddingValue),
                // email field
                EmailField(),
                const Gap(AppPaddings.smallPaddingValue),
                // Password Field
                PasswordField(),
                const Gap(AppPaddings.smallPaddingValue),
                // I have read the Privacy Policy
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: iHaveRead,
                        children: [
                          TextSpan(
                            text: privacyPolicy,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('SIGN UP tapped');
                              },
                          )
                        ],
                      ),
                    ),
                    Checkbox.adaptive(
                      value: false,
                      onChanged: (_) {},
                    ),
                  ],
                )
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

          //ALREADY HAVE AN ACCOUNT?
          Gap(
            context.dynamicHeight(0.05),
          ),
          Text.rich(
            TextSpan(
              text: alreadyHaveAnAccount,
              children: [
                TextSpan(
                  text: signIn,
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
