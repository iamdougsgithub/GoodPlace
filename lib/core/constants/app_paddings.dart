import 'package:flutter/material.dart';

class AppPaddings {
  /// Sign In , Sign Up ve Welcome sayfalarında kullanılan horizontal padding.
  ///
  /// Padding : 20 px
  static const EdgeInsets authScreenHorizontalPadding =
      EdgeInsets.symmetric(horizontal: 20);

  /// Onboarding sayfalarında kullanılan horizontal padding.
  /// Padding : 28 px
  static const EdgeInsets onboardingScreenHorizontalPadding =
      EdgeInsets.symmetric(horizontal: 28);

  /// Home sayfasında kullanılan horizontal padding.
  /// Padding : 8 px
  ///! NOT : Bu ileride değiştirilebilir.
  static const EdgeInsets homeScreenHorizontalPadding =
      EdgeInsets.symmetric(horizontal: 8);

  /// 4 px.
  static const double xxsmallPaddingValue = 4.0;

  /// 20 px.
  static const double smallPaddingValue = 20.0;

  /// 30 px.
  static const double mediumPaddingValue = 30.0;

  /// 40 px.
  static const double largePaddingValue = 40.0;
}
