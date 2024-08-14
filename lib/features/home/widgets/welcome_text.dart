import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';

import '../../../config/theme.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/widgets/image_container.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  final String welcomingText = "Good Morning";
  final String userName = "memrec";
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AssetImageContainer(
          path: AppAssets.goodAfternoonIcon,
        ),

        /// TODO : Bu logic kısmından alınacak
        // Welcoming Text
        Text(
          welcomingText,
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
