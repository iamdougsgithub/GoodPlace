// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:good_place/config/theme.dart';
import 'package:good_place/core/utils/models/habit_model.dart';
import 'package:good_place/features/user_data/habit_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/widgets/card_background_cover.dart';

import '../../../core/constants/app_border_radius.dart';

class StreakCardWidget extends StatelessWidget {
  const StreakCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitProvider>(
      builder: (context, provider, child) => Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          image: DecorationImage(
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            image: NetworkImage(
              "https://images.unsplash.com/photo-1518655048521-f130df041f66?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            ),
          ),
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(AppBorderRadius.mediumBorderRadiusValue),
        ),
        child: CardBackgroundImageFilter(
          child: Padding(
            padding: EdgeInsets.all(AppPaddings.mediumPaddingValue),
            child: _StreakCard(),
          ),
        ),
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  final HabitModel? habitModel;
  const _StreakCard({this.habitModel});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
