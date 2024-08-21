import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/features/auth/pages/sign_in_page.dart';
import '../mixins/sign_up_page_mixin.dart';
import '../../../core/utils/mixins/form_validators_mixin.dart';
import '../../../config/theme.dart';

import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/widgets/custom_buttons.dart';
import '../../../core/utils/widgets/custom_text_form_field.dart';
import '../widgets/google_button.dart';
import 'auth_base_view.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = "sign-up";
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SignUpPageMixin {
  @override
  Widget build(BuildContext context) {
    return AuthBaseView(
      title: title,
      child: Column(
        children: [
          /// Google Button

          const GoogleButton(),
          const MaxGap(AppPaddings.largePaddingValue),

          /// log in with email text
          Text(
            orLogInWithEmail,
            style: context.textTheme.labelLarge
                ?.copyWith(color: AppColors.lightTextColor),
          ),
          const MaxGap(AppPaddings.largePaddingValue),

          /// form
          _SignUpForm(
            formKey: formKey,
            iHaveRead: iHaveRead,
            privacyPolicy: privacyPolicy,
            nameController: nameController,
            emailController: emailController,
            passwordController: passwordController,
          ),
          const MaxGap(AppPaddings.smallPaddingValue),
          _PrivacyPolicyCheckBox(
            iHaveRead: iHaveRead,
            privacyPolicy: privacyPolicy,
            checkBoxVal: checkBoxValue,
            changeCheckBoxVal: changeCheckBoxState,
          ),
          const MaxGap(AppPaddings.mediumPaddingValue),

          /// Get Started Button
          Row(
            children: [
              ExpandedFilledButton(
                label: buttonLabel,
                onPressed: onGetStartedTapped,
              ),
            ],
          ),

          const Spacer(),

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
                ),
              ],
            ),
          ),
          const MaxGap(AppPaddings.smallPaddingValue),
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
          const MaxGap(AppPaddings.smallPaddingValue),
          // email field
          EmailField(
            controller: emailController,
            validator: emailValidator,
          ),
          const MaxGap(AppPaddings.smallPaddingValue),
          // Password Field
          PasswordField(
            controller: passwordController,
            validator: passwordValidator,
          ),
        ],
      ),
    );
  }
}

class _PrivacyPolicyCheckBox extends StatefulWidget {
  const _PrivacyPolicyCheckBox({
    required this.iHaveRead,
    required this.privacyPolicy,
    required this.checkBoxVal,
    required this.changeCheckBoxVal,
  });
  final bool checkBoxVal;
  final void Function(bool) changeCheckBoxVal;
  final String iHaveRead;
  final String privacyPolicy;

  @override
  State<_PrivacyPolicyCheckBox> createState() => _PrivacyPolicyCheckBoxState();
}

class _PrivacyPolicyCheckBoxState extends State<_PrivacyPolicyCheckBox> {
  late bool? val;
  @override
  void initState() {
    super.initState();
    val = widget.checkBoxVal;
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: context.dynamicWidth(1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                text: widget.iHaveRead,
                style: context.textTheme.labelLarge
                    ?.copyWith(color: AppColors.lightTextColor),
                children: [
                  TextSpan(
                      text: widget.privacyPolicy,
                      style: context.textTheme.labelLarge
                          ?.copyWith(color: AppColors.primaryButtonColor),
                      recognizer: TapGestureRecognizer()..onTap = () => {})
                ],
              ),
            ),
            Checkbox.adaptive(
              value: val,
              onChanged: (newVal) {
                widget.changeCheckBoxVal(newVal ??= false);
                setState(() {
                  val = newVal;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
