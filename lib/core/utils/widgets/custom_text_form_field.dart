import 'package:flutter/material.dart';
import 'package:good_place/core/constants/app_assets.dart';

abstract class _CustomFormField extends TextFormField {
  _CustomFormField({
    super.key,
    super.controller,
    this.label = "",
    this.hintText,
    this.icon,
    this.suffix,
    this.autofillHints,
    this.keyboardType,
    this.textInputAction,
    super.validator,
    super.obscureText,
    this.helper,
    this.expands = false,
    this.constraints,
    this.buildCounter,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
  });

  final int? maxLength;
  final TextCapitalization textCapitalization;
  final String label;
  final String? hintText;
  final Widget? icon;
  final Widget? suffix;
  final Widget? helper;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final bool expands;
  final BoxConstraints? constraints;
  final InputCounterWidgetBuilder? buildCounter;
  @override
  AutovalidateMode get autovalidateMode => AutovalidateMode.onUserInteraction;

  bool validated = false;
  @override
  FormFieldBuilder<String> get builder =>
      (_) => StatefulBuilder(builder: (context, setState) {
            return TextFormField(
              buildCounter: buildCounter,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                label: Text(label),
                hintText: hintText,
                icon: icon,
                suffix: validator != null
                    ? validated
                        ? AppAssets.textFieldCheckIcon
                        : AppAssets.textFieldXIcon
                    : suffix,
                constraints: constraints,
                alignLabelWithHint: true,
              ),
              onChanged: (value) {
                if (validator != null) {
                  var validatorValue = validator!(value);

                  if (validatorValue == null) {
                    setState(
                      () {
                        validated = true;
                      },
                    );
                  } else {
                    setState(
                      () {
                        validated = false;
                      },
                    );
                  }
                }
              },
              autofillHints: autofillHints,
              autovalidateMode: autovalidateMode,
              controller: controller,
              keyboardType: keyboardType,
              validator: validator,
              textInputAction: textInputAction,
              textCapitalization: textCapitalization,
              expands: expands,
              minLines: expands ? null : 1,
              maxLines: expands ? null : 1,
              maxLength: maxLength,
              textAlignVertical: TextAlignVertical.top,
            );
          });
}

class EmailField extends _CustomFormField {
  EmailField({
    super.key,
    super.controller,
    super.label = "Email",
    super.hintText = "Enter your email",
    super.keyboardType = TextInputType.emailAddress,
    super.textInputAction = TextInputAction.next,
    super.validator,
  });

  @override
  TextInputType? get keyboardType => TextInputType.emailAddress;
  @override
  Iterable<String>? get autofillHints => [AutofillHints.email];
}

class PasswordField extends _CustomFormField {
  PasswordField({
    super.key,
    super.controller,
    super.label,
    super.hintText,
    super.keyboardType = TextInputType.emailAddress,
    super.textInputAction = TextInputAction.next,
    super.validator,
    super.helper,
  });

  @override
  String get label => "Password";
  @override
  String? get hintText => "Enter your password";
  @override
  TextInputType? get keyboardType => TextInputType.visiblePassword;

  bool _obscureText = true;

  @override
  FormFieldBuilder<String> get builder => (_) => StatefulBuilder(
        builder: (context, setState) => TextFormField(
          decoration: InputDecoration(
            label: Text(label),
            helper: helper,
            hintText: hintText,
            icon: icon,
            suffix: GestureDetector(
              child: Image.asset(
                _obscureText
                    ? AppAssets.passwordHideIcon
                    : AppAssets.passwordShowIcon,
                filterQuality: FilterQuality.high,
              ),
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
          autofillHints: autofillHints,
          autovalidateMode: autovalidateMode,
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          textInputAction: textInputAction,
          obscureText: _obscureText,
        ),
      );
}

class NormalTextFormField extends _CustomFormField {
  NormalTextFormField({
    super.key,
    super.controller,
    super.label = "Header",
    super.hintText,
    super.keyboardType = TextInputType.emailAddress,
    super.textInputAction = TextInputAction.next,
    super.validator,
    super.buildCounter,
    super.maxLength,
    super.textCapitalization,
  });

  @override
  TextInputType? get keyboardType => TextInputType.text;
}
