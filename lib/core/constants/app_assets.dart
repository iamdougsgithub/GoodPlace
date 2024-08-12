import 'package:flutter/material.dart';

part "enums/assets_path_enum.dart";

class AppAssets {
  static String googleIcon = _AssetsPathEnum.googleIcon.path;
  static String averagePerDailyCardIcon =
      _AssetsPathEnum.averagePerDailyCardIcon.path;
  static String welcomePageImage = _AssetsPathEnum.welcomePageImage.path;
  static String streakCardImage = _AssetsPathEnum.streakCardImage.path;
  static String authTopBackgroundImage =
      _AssetsPathEnum.authTopBackgroundImage.path;
  static String onboardingFirstPageImage =
      _AssetsPathEnum.onboardingFirstPageImage.path;
  static String onboardingSecondPageImage =
      _AssetsPathEnum.onboardingSecondPageImage.path;
  static String onboardingThirdPageImage =
      _AssetsPathEnum.onboardingThirdPageImage.path;
  static String onboardingFourthPageImage =
      _AssetsPathEnum.onboardingFourthPageImage.path;
  static String onboardingSkipIcon = _AssetsPathEnum.onboardingSkipIcon.path;

  static String passwordHideIcon = _AssetsPathEnum.passwordHide.path;
  static String passwordShowIcon = _AssetsPathEnum.passwordShow.path;

  static Widget chartIcon = const Icon(
    Icons.show_chart,
    color: Color(0xffF3E339),
  );
  static Widget calendarIcon = const Icon(
    Icons.calendar_today_outlined,
    color: Color(0xffFFB8B8),
  );
  static Widget checkIcon = const Icon(
    Icons.check,
    color: Color(0xffD4EE81),
  );
}
