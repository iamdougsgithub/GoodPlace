import 'package:flutter/material.dart';
import 'package:good_place/core/constants/app_assets.dart';
import 'package:good_place/features/onboarding/onboarding_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingViewModel extends ChangeNotifier {
  final PageController pageController = PageController();
  int currentIndex = 0;

  final List<OnboardingContent> onboardingContents = [
    OnboardingContent(
      image: AppAssets.onboardingFirstPageImage,
      title: 'Track Your Habit',
      description:
          "Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals",
    ),
    OnboardingContent(
      image: AppAssets.onboardingSecondPageImage,
      title: 'Get Burn',
      description:
          'Let’s keep burning, to achive yours goals, it hurts only temporarily, if you give up now you will be in pain forever',
    ),
    OnboardingContent(
      image: AppAssets.onboardingThirdPageImage,
      title: 'Eat Well',
      description:
          "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun",
    ),
    OnboardingContent(
      image: AppAssets.onboardingFourthPageImage,
      title: 'Morning yoga',
      description:
          "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun",
    )
  ];

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
  }

  void nextPage() {
    if (currentIndex < onboardingContents.length - 1) {
      currentIndex++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      completeOnboarding();
      // Onboarding tamamlandıktan sonra isteen sayfaya yönlendirme buraya da eklenebilir.
    }
    notifyListeners();
  }

  void previousPage() {
    if (currentIndex > 0) {
      currentIndex--;
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      notifyListeners();
    }
  }

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
