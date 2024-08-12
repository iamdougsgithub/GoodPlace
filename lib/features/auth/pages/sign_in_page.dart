import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/features/auth/mixins/sign_in_page_mixin.dart';
import '../../../config/theme.dart';

import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/widgets/custom_buttons.dart';
import '../../../core/utils/widgets/custom_text_form_field.dart';
import '../widgets/google_button.dart';
import 'auth_base_view.dart';

class SignInPage extends StatefulWidget {
  static const routeName = "sign-in";

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with SignInPageMixin {
  @override
  Widget build(BuildContext context) {
    return AuthBaseView(
      title: title,
      child: Column(
        children: [
          /// Google Button
          const GoogleButton(),
          const Gap(AppPaddings.largePaddingValue),
          // log in with email text
          Text(
            orLoginWithEmail,
            style: context.textTheme.labelLarge?.copyWith(
              color: AppColors.lightTextColor,
            ),
          ),
          const Gap(AppPaddings.largePaddingValue),
          // form
          Form(
            key: formKey,
            child: Column(
              children: [
                // email field
                EmailField(
                  controller: emailController,
                ),
                const Gap(AppPaddings.smallPaddingValue),
                // Password Field
                PasswordField(
                  controller: passwordController,
                ),
              ],
            ),
          ),
          const Gap(AppPaddings.mediumPaddingValue),
          // Login button
          Row(
            children: [
              ExpandedFilledButton(
                label: buttonLabel,
                onPressed: () => onLoginTapped(),
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
            context.dynamicHeight(0.1),
          ),
          //DON’T HAVE AN ACCOUNT?
          Text.rich(
            TextSpan(
              text: dontHaveAnAccount,
              style: context.textTheme.labelLarge
                  ?.copyWith(color: AppColors.lightTextColor),
              children: [
                TextSpan(
                  text: signUp,
                  style: context.textTheme.labelLarge?.copyWith(
                    color: AppColors.primaryButtonColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => onSignUpTapped(context),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
