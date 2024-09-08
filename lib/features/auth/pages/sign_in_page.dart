import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/utils/widgets/custom_toast.dart';
import 'package:good_place/features/auth/firebase/authService.dart';
import 'package:good_place/features/auth/mixins/sign_in_page_mixin.dart';
import 'package:good_place/logger.dart';
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
          const MaxGap(AppPaddings.largePaddingValue),
          // log in with email text
          Text(
            orLoginWithEmail,
            style: context.textTheme.labelLarge?.copyWith(
              color: AppColors.lightTextColor,
            ),
          ),
          const MaxGap(AppPaddings.largePaddingValue),
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
          const MaxGap(AppPaddings.mediumPaddingValue),
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
                onPressed: () => showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  isScrollControlled: true,
                  backgroundColor: AppColors.authScaffoldColor,
                  constraints: BoxConstraints(
                    maxHeight: context.dynamicHeight(0.8),
                    minWidth: context.dynamicWidth(1),
                  ),
                  isDismissible: false,
                  builder: (context) => _ResetPasswordSheet(
                    passwordResetController: passwordResetController,
                  ),
                ), //  AuthService().sendPasswordResetEmail(email: ),
                child: Text(forgotPassword),
              ),
            ],
          ),

          const Spacer(),
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

class _ResetPasswordSheet extends StatefulWidget {
  const _ResetPasswordSheet({
    required this.passwordResetController,
  });

  final TextEditingController passwordResetController;

  @override
  State<_ResetPasswordSheet> createState() => _ResetPasswordSheetState();
}

class _ResetPasswordSheetState extends State<_ResetPasswordSheet>
    with EmailValidator {
  @override
  void dispose() {
    widget.passwordResetController.clear();
    super.dispose();
  }

  send() {
    if (EmailValidator.validate(widget.passwordResetController.text)) {
      AuthService()
          .sendPasswordResetEmail(email: widget.passwordResetController.text)
          .whenComplete(
            () => mounted ? context.pop() : null,
          )
          .whenComplete(() => Toast.succToast(
              title: "Password Reset Email Sent",
              desc: "Please check your email."));
    } else {
      Toast.errToast(title: "Please provide valid email address");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.authScreenHorizontalPadding,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Reset Password",
              style: context.textTheme.titleMedium,
            ),
            EmailField(
              controller: widget.passwordResetController,
              textInputAction: TextInputAction.done,
            ),
            Row(
              children: [
                ExpandedFilledButton(
                  label: "Send",
                  onPressed: () =>
                      widget.passwordResetController.text.trim().isNotEmpty
                          ? send()
                          : null,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
