// ignore_for_file: unused_field

part of '../app_assets.dart';

enum _AssetsPathEnum {
  /// Icons
  googleIcon("${_rootIconPath}ic_google.png"),

  /// Average per daily card'ında kullanılan icon.
  averagePerDailyCardIcon("${_rootIconPath}ic_avarage_per_daily.png"),
  passwordShow("${_rootIconPath}ic_password_shown.png"),
  passwordHide("${_rootIconPath}ic_password_hide.png"),

  /// Images

  /// Sign In ve Sign Up sayfalarında kullanılan image
  authTopBackgroundImage("${_rootImagePath}auth_screens_image.png"),
  welcomePageImage("${_rootImagePath}img_welcome.png"),

  onboardingFirstPageImage("${_rootImagePath}img_onbarding_1.png"),
  onboardingSecondPageImage("${_rootImagePath}img_onbarding_2.png"),
  onboardingThirdPageImage("${_rootImagePath}img_onbarding_3.png"),
  onboardingFourthPageImage("${_rootImagePath}img_onbarding_4.png"),
  onboardingSkipIcon("${_rootIconPath}skip_button_onboarding.png"),
  ;

  static const String _rootIconPath = "lib/core/assets/icons/";
  static const String _rootImagePath = "lib/core/assets/images/";

  final String path;

  /// Uygulama içerisinde kullanılan resimlerin Path'leri bu enumda toplandı.
  const _AssetsPathEnum(this.path);
}
