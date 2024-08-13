import 'package:flutter/material.dart';

import '../../config/theme.dart';

part "enums/assets_path_enum.dart";

class AppAssets {
  /// Icons
  static String googleIcon = _AssetsPathEnum.googleIcon.path;
  static String onboardingSkipIcon = _AssetsPathEnum.onboardingSkipIcon.path;

  static String passwordHideIcon = _AssetsPathEnum.passwordHide.path;
  static String passwordShowIcon = _AssetsPathEnum.passwordShow.path;
  static String averagePerDailyCardIcon =
      _AssetsPathEnum.averagePerDailyCardIcon.path;
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
  static Widget textFieldCheckIcon = Icon(
    Icons.check,
    color: AppColors.succDark,
  );
  static Widget textFieldXIcon = Icon(
    Icons.cancel_outlined,
    color: AppColors.errDark,
  );
  static Widget fabAddIcon = const Icon(
    Icons.add,
    color: AppColors.secondaryButtonColor,
  );
  static Widget logOutIcon = Icon(
    Icons.logout_outlined,
    color: AppColors.errDark,
  );
  static Widget homeIcon = const Icon(
    Icons.home_rounded,
  );

  static String goodAfternoonIcon = _AssetsPathEnum.goodAfternoonIcon.path;
  static String goodMorningIcon = _AssetsPathEnum.goodMorningIcon.path;
  static String goodNightIcon = _AssetsPathEnum.goodNightIcon.path;

  /// Images
  ///
  static String welcomePageImage = _AssetsPathEnum.welcomePageImage.path;
  static String streakCardImage = _AssetsPathEnum.streakCardImage.path;
  static String authTopBackgroundImage =
      _AssetsPathEnum.authTopBackgroundImage.path;
  static String motivationCardBgImage =
      _AssetsPathEnum.motivationCardBgImage.path;
  static String onboardingFirstPageImage =
      _AssetsPathEnum.onboardingFirstPageImage.path;
  static String onboardingSecondPageImage =
      _AssetsPathEnum.onboardingSecondPageImage.path;
  static String onboardingThirdPageImage =
      _AssetsPathEnum.onboardingThirdPageImage.path;
  static String onboardingFourthPageImage =
      _AssetsPathEnum.onboardingFourthPageImage.path;
}
