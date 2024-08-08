import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/widgets/custom_buttons.dart';
import '../../../core/utils/widgets/image_container.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

// TODO : Buraya da Theme uygula.
  final String hiWelcome = "Hi, Welcome";
  final String toGoodPlace = "to GoodPlace";
  final String desc =
      "Explore the app, Find some peace of mind to achieve good habits.";
  final String buttonLabel = "GET STARTED";
  @override
  Widget build(BuildContext context) {
    // TODO : bunu da theme içinde hallet.
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xff8C96FF),
    ));
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: AppPaddings.authScreenHorizontalPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ExpandedFilledButton(
              label: buttonLabel,
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 2,
          ),
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppPaddings.largePaddingValue),
            child: Column(
              children: [
                Text(
                  hiWelcome,
                  style: GoogleFonts.rubik(),
                ),
                Text(
                  toGoodPlace,
                ),
                const Gap(AppPaddings.smallPaddingValue),
                //desc
                Text(
                  desc,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          // Image
          AssetImageContainer(
            path: AppAssets.welcomePageImage,
            fit: BoxFit.fill,
            width: context.dynamicWidth(1),
          ),
        ],
      ),
    );
  }
}
