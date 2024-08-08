import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/features/auth/enums/auth_type_enum.dart';
import 'package:good_place/features/auth/pages/auth_base_view.dart';
import 'package:good_place/features/auth/widgets/google_button.dart';

import '../../../core/constants/app_paddings.dart';
import '../../../core/utils/widgets/custom_buttons.dart';
import '../../../core/utils/widgets/custom_text_form_field.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AuthBaseView(
      title: "Welcome Back",
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
                label: "LOG IN",
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
                child: const Text("Forgot Password"),
              ),
            ],
          ),
          Gap(
            context.dynamicHeight(0.14),
          ),
          //DON’T HAVE AN ACCOUNT?

          Text.rich(
            TextSpan(
              text: "DON’T HAVE AN ACCOUNT? ",
              children: [
                TextSpan(
                  text: "SIGN UP",
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
