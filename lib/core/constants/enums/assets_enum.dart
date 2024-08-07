enum AssetsEnum {
  googleIcon("${_rootIconPath}ic_google.png"),

  /// Average per daily card'ında kullanılan icon.
  averagePerDailyCardIcon("${_rootIconPath}ic_avarage_per_daily.png"),

  /// Sign In ve Sign Up sayfalarında kullanılan image
  authTopBackgroundImage("${_rootImagePath}auth_screens_image.png"),
  welcomePageImage("${_rootImagePath}img_welcome.png"),

  onboardingFirstPageImage("${_rootImagePath}img_Onbarding_1.png"),
  onboardingSecondPageImage("${_rootImagePath}img_Onbarding_2.png"),
  onboardingThirdPageImage("${_rootImagePath}img_Onbarding_3.png"),
  onboardingFourthPageImage("${_rootImagePath}img_Onbarding_4.png"),
  ;

  static const String _rootIconPath = "lib/core/assets/icons/";
  static const String _rootImagePath = "lib/core/assets/images/";

  final String path;

  /// Uygulama içerisinde kullanılan resimlerin Path'leri bu enumda toplandı.
  const AssetsEnum(this.path);
}
