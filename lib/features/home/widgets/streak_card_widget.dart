// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:good_place/config/theme.dart';
import 'package:good_place/core/constants/app_assets.dart';
import 'package:good_place/core/constants/app_paddings.dart';
import 'package:good_place/core/extensions/context_extension.dart';

import '../../../core/constants/app_border_radius.dart';

class StreakCardWidget extends StatelessWidget {
  const StreakCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            filterQuality: FilterQuality.high,
            fit: BoxFit.fill,
            image: AssetImage(
              AppAssets.welcomePageImage,
            ),
          ),
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(AppBorderRadius.mediumBorderRadiusValue),
        ),
        child: ColoredBox(
          color: AppColors.darkTextColor.withOpacity(0.1),
          child: Padding(
            padding: EdgeInsets.all(AppPaddings.mediumPaddingValue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1 Day",
                  style: context.textTheme.headlineMedium?.copyWith(
                    color: AppColors.textFieldFillColor,
                  ),
                ),
                Text(
                  "Your current streak",
                  style: context.textTheme.labelLarge?.copyWith(
                    color: AppColors.secondaryButtonColor,
                  ),
                ),
                Text(
                  "1 Day",
                  style: context.textTheme.labelLarge?.copyWith(
                    fontSize: 16,
                    color: AppColors.textFieldFillColor,
                  ),
                ),
                Text(
                  "Your longest streak",
                  style: context.textTheme.labelLarge?.copyWith(
                    color: AppColors.secondaryButtonColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
