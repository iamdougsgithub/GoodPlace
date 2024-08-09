import 'package:flutter/material.dart';
import 'package:good_place/core/constants/app_assets.dart';
import 'package:good_place/core/constants/app_paddings.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/core/utils/widgets/image_container.dart';
import 'package:good_place/features/auth/pages/sign_in_page.dart';
import 'package:good_place/features/onboarding/onboarding_view_model.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatelessWidget {
  static const routeName = "onboarding";
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingViewModel(),
      child: Consumer<OnboardingViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Stack(
              children: [
                PageView.builder(
                  controller: viewModel.pageController,
                  onPageChanged: (index) => viewModel.setCurrentIndex(index),
                  itemCount: viewModel.onboardingContents.length,
                  itemBuilder: (context, index) {
                    final content = viewModel.onboardingContents[index];
                    return Column(
                      children: [
                        // onboarding image
                        SizedBox(
                          width: double.infinity,
                          //    height: 422,
                          child: AssetImageContainer(
                            path: content.image,
                            width: double.infinity,
                            height: null,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(height: 28),
                        // Onboarding Text
                        Padding(
                          padding: AppPaddings.authScreenHorizontalPadding,
                          // const EdgeInsets.only(left: 28.0, right: 32.0),
                          child: SizedBox(
                            width: 315,
                            height: 114,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //title
                                Text(content.title,
                                    style: context.textTheme
                                        .titleMedium //Color(0xFF1D1617),
                                    ),
                                const SizedBox(height: 8),
                                //body
                                Text(content.description,
                                    style: context.textTheme
                                        .bodyMedium //Color(0xFF7B6F72),

                                    ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (viewModel.currentIndex ==
                              viewModel.onboardingContents.length - 1) {
                            viewModel.completeOnboarding();
                            context.navigator
                                .pushReplacementNamed(SignInPage.routeName);
                          } else {
                            viewModel.nextPage();
                          }
                        },
                        /*
                        style: TextButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16),
                        ),*/
                        child: AssetImageContainer(
                          path: AppAssets.onboardingSkipIcon,
                          width: 60,
                          height: 60,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
