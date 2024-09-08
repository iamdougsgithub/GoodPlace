import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => openPrivacyPolicyDialog(context),
                  )
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

  final String _policyText = """
# Privacy Policy for GoodPlace

**Effective Date**: 23/08/24

GoodPlace ("we", "our", or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, and share your personal information when you use our AI-powered habit-tracking application.

### 1. Information We Collect
We collect information that you provide directly to us and information that is automatically collected through your use of the app:

- **Personal Information**: When you create an account, we may collect personal details such as your name, email address, and any other information you choose to provide.
- **Usage Data**: We automatically collect data about how you use GoodPlace, such as your interactions, preferences, and the habits you track.
- **Device Information**: We collect information about the device you use to access the app, including IP address, device type, operating system, and app version.
- **AI-Generated Insights**: Our AI may generate insights based on your tracked habits, which are stored to enhance your experience.

### 2. How We Use Your Information
We use your information for the following purposes:

- To provide, maintain, and improve GoodPlace.
- To personalize your experience and offer AI-driven recommendations.
- To communicate with you, including sending app-related notifications and updates.
- To analyze usage patterns and enhance app performance.
- To comply with legal obligations or to protect our rights.

### 3. How We Share Your Information
We do not share your personal information with third parties except in the following cases:

- **Service Providers**: We may share your data with third-party service providers who assist us in operating the app, provided they adhere to strict confidentiality and data security measures.
- **Legal Compliance**: We may disclose your information when required by law or to respond to legal requests.
- **Business Transfers**: In the event of a merger, acquisition, or sale of assets, your information may be transferred as part of the transaction.

### 4. Data Security
We implement reasonable security measures to protect your information. However, no system is completely secure, and we cannot guarantee the absolute security of your data.

### 5. Your Rights
You have the following rights regarding your personal information:

- **Access**: You can request access to your personal data that we hold.
- **Correction**: You can update or correct your information within the app.
- **Deletion**: You can request the deletion of your account and associated data.
- **Objection**: You can object to our processing of your personal data for specific purposes.

To exercise any of these rights, please contact us at [Insert Contact Information].

### 6. Data Retention
We retain your personal information for as long as necessary to fulfill the purposes outlined in this policy unless a longer retention period is required or permitted by law.

### 7. Children's Privacy
GoodPlace is not intended for use by individuals under the age of 13. We do not knowingly collect personal information from children under 13. If we become aware that a child under 13 has provided us with personal data, we will delete it promptly.

### 8. Changes to This Privacy Policy
We may update this Privacy Policy from time to time. We will notify you of any significant changes by posting the new policy within the app and updating the "Effective Date."

### 9. Contact Us
If you have any questions about this Privacy Policy or our practices, please contact us at [Insert Contact Information].

---
  """;

  openPrivacyPolicyDialog(
    BuildContext context,
  ) {
    showDialog(
      barrierDismissible: true,
      context: context,
      useSafeArea: true,
      builder: (context) => AlertDialog.adaptive(
        scrollable: true,
        // title: const Text("Privacy Policy"),
        content: SizedBox(
          height: context.dynamicHeight(0.7),
          width: context.dynamicWidth(1),
          child: Markdown(
            data: _policyText,
            // shrinkWrap: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                val = true;
              });
              context.pop();
            },
            child: const Text("Confirm"),
          )
        ],
      ),
    );
  }
}
