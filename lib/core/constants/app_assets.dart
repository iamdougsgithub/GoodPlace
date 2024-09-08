import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';

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

  static Widget aiIcon(double width, double height) => Lottie.asset(
        AppAssets.aiButtonAnimation,
        width: width,
        height: height,
        fit: BoxFit.fill,
      );
  static Widget noHabitsFound = Lottie.asset(
    _AssetsPathEnum.noHabitsFound.path,
    fit: BoxFit.fill,
    alignment: Alignment.center,
  );
  static Widget streakCardAnimation = Lottie.asset(
    _AssetsPathEnum.streakCardAnimation.path,
    alignment: Alignment.topRight,
    width: 64,
    height: 64,
  );
  static Widget totalDonePerDayCardAnimation(
          {required double width, required double height}) =>
      Lottie.asset(
        _AssetsPathEnum.totalDonePerDayCardAnimation.path,
        alignment: Alignment.topRight,
        width: width,
        height: height,
      );
  static Widget longTimeNotDoneCardAnimation(
          {required double width, required double height}) =>
      Lottie.asset(
        _AssetsPathEnum.longTimeNotDoneCard.path,
        alignment: Alignment.topRight,
        width: width,
        height: height,
      );
  static String aiChatSendButton = _AssetsPathEnum.aiChatSendButton.path;

  static String homeIconPath = _AssetsPathEnum.homeIcon.path;

  static Widget editIcon = const Icon(
    Icons.edit,
    color: Colors.white,
  );

  static Widget calendarIcon = const Icon(
    Icons.calendar_today_outlined,
    color: Color(0xffFFB8B8),
  );
  static Widget checkIcon = const Icon(
    Icons.check,
    color: Color(0xffD4EE81),
  );
  static Widget addImageIcon = const Icon(Icons.image);
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
  // static Widget homeIcon = const Icon(
  //   Icons.home_rounded,
  // );
  static Widget removeIcon = Icon(
    Icons.delete_outlined,
    color: AppColors.errLight,
  );
  static Widget sortIcon = const Icon(Icons.sort_rounded);
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

  // Animations
  static String aiButtonAnimation = _AssetsPathEnum.aiButtonAnimation.path;
  static String wellDoneAnimation = _AssetsPathEnum.wellDoneAnimation.path;
}
