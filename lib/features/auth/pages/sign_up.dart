import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/utils/mixins/form_validators_mixin.dart';
import '../../../config/theme.dart';

import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/widgets/custom_buttons.dart';
import '../../../core/utils/widgets/custom_text_form_field.dart';
import '../widgets/google_button.dart';
import 'auth_base_view.dart';
import 'sign_in_page.dart';

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

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void onSignInTapped(BuildContext context) =>
      context.navigator.pushReplacementNamed(SignInPage.routeName);

  void onGetStartedTapped() {}

  @override
  Widget build(BuildContext context) {
    return AuthBaseView(
      title: title,
      child: Column(
        children: [
          /// Google Button

          const GoogleButton(),
          const Gap(AppPaddings.largePaddingValue),

          /// log in with email text
          Text(
            orLogInWithEmail,
            style: context.textTheme.labelLarge
                ?.copyWith(color: AppColors.lightTextColor),
          ),
          const Gap(AppPaddings.largePaddingValue),

          /// form
          _SignUpForm(
            formKey: formKey,
            iHaveRead: iHaveRead,
            privacyPolicy: privacyPolicy,
            nameController: nameController,
            emailController: emailController,
            passwordController: passwordController,
          ),
          const Gap(AppPaddings.mediumPaddingValue),

          /// Get Started Button
          Row(
            children: [
              ExpandedFilledButton(
                label: buttonLabel,
                onPressed: onGetStartedTapped,
              ),
            ],
          ),

          Gap(
            context.dynamicHeight(0.02),
          ),

          /// ALREADY HAVE AN ACCOUNT?
          Text.rich(
            TextSpan(
              text: alreadyHaveAnAccount,
              style: context.textTheme.labelLarge
                  ?.copyWith(color: AppColors.lightTextColor),
              children: [
                /// Sign In Text Button
                TextSpan(
                  text: signIn,
                  style: context.textTheme.labelLarge
                      ?.copyWith(color: AppColors.primaryButtonColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => onSignInTapped(
                          context,
                        ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SignUpForm extends StatelessWidget with FormValidatorsMixin {
  const _SignUpForm({
    required this.formKey,
    required this.iHaveRead,
    required this.privacyPolicy,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final String iHaveRead;
  final String privacyPolicy;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // name field
          NormalTextFormField(
            label: "Name",
            validator: nameValidator,
            controller: nameController,
          ),
          const Gap(AppPaddings.smallPaddingValue),
          // email field
          EmailField(
            controller: emailController,
            validator: emailValidator,
          ),
          const Gap(AppPaddings.smallPaddingValue),
          // Password Field
          PasswordField(
            controller: passwordController,
            validator: passwordValidator,
          ),
          const Gap(AppPaddings.smallPaddingValue),
          // I have read the Privacy Policy
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: iHaveRead,
                  style: context.textTheme.labelLarge
                      ?.copyWith(color: AppColors.lightTextColor),
                  children: [
                    TextSpan(
                        text: privacyPolicy,
                        style: context.textTheme.labelLarge
                            ?.copyWith(color: AppColors.primaryButtonColor),
                        recognizer: TapGestureRecognizer()..onTap = () => {})
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
    );
  }
}
