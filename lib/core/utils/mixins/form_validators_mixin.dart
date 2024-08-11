import 'package:email_validator/email_validator.dart';

mixin FormValidatorsMixin {
  String? nameValidator(String? val) {
    val ??= "";
    if (val.isEmpty) {
      return "Name field can't be empty !";
    } else {
      return null;
    }
  }

  String? emailValidator(String? val) {
    val ??= "";
    if (!EmailValidator.validate(val)) {
      return "Please provide a valid email address.\nEx:xxx@x.com";
    } else {
      return null;
    }
  }

  String? passwordValidator(String? val) {
    val ??= "";
    if (val.length < 6) {
      return "Password must be longer than 6 characters !";
    } else {
      return null;
    }
  }
}
