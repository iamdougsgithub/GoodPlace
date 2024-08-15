import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/constants/app_paddings.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/features/home/welcome_utils.dart';

import '../../../config/theme.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  final String userName = "memrec";

  @override
  Widget build(BuildContext context) {
    final welcomeData = WelcomeUtils.getWelcomeData();

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        welcomeData['icon'],

        /// TODO : Bu logic kısmından alınacak
        // Welcoming Text

        Text(
          welcomeData['message'],
          style: context.textTheme.bodyLarge?.copyWith(
            // fontWeight: FontWeight.w100,
            foreground: Paint()..color = AppColors.orangeTextColor,
            fontStyle: FontStyle.italic,
            // fontSize: 10,
          ),
        ),
        const Gap(AppPaddings.xxsmallPaddingValue),

        const Gap(AppPaddings.xxsmallPaddingValue),
        // Username
        Text(
          userName,
          style: context.textTheme.bodyLarge?.copyWith(
            foreground: Paint()..color = AppColors.authScaffoldColor,
          ),
        ),
      ],
    );
  }
}
