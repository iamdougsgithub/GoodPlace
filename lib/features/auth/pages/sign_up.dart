import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/extensions/context_extension.dart';

import '../../../core/constants/app_paddings.dart';
import '../../../core/utils/widgets/custom_buttons.dart';
import '../../../core/utils/widgets/custom_text_form_field.dart';
import '../widgets/google_button.dart';
import 'auth_base_view.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AuthBaseView(
      title: "Create your account ",
      child: Column(
        children: [
          // Google Button
          // TODO: Google button logic ekle.
          const GoogleButton(),
          const Gap(AppPaddings.largePaddingValue),
          // log in with email text
          const Text("OR LOG IN WITH EMAIL"),
          const Gap(AppPaddings.largePaddingValue),
          // form
          Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // name field
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NormalTextFormField(),
                    const Gap(AppPaddings.smallPaddingValue),
                  ],
                ),
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
                        text: "I have read the ",
                        children: [
                          TextSpan(
                            text: "Privacy Policy",
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
                label: "GET STARTED",
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
              text: "ALREADY HAVE AN ACCOUNT? ",
              children: [
                TextSpan(
                  text: "SIGN IN",
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
