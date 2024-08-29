import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/resourcers/tutorial_manager.dart';
import 'package:good_place/core/utils/widgets/tutorial_widget.dart';
import 'package:good_place/features/user_data/habit_provider.dart';
import 'package:provider/provider.dart';
import '../../../config/theme.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_border_radius.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';

class StatGridWidget extends StatelessWidget {
  const StatGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitProvider>(
      builder: (context, habitProvider, child) {
        return GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppPaddings.smallPaddingValue,
            crossAxisSpacing: AppPaddings.smallPaddingValue,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            TutorialWidget(
              tutorialKey: TutorialKeys.statCard,
              child: _StatCard(
                icon: AppAssets.calendarIcon,
                data: "${habitProvider.getLongestStreak()}",
                label: "Longest streak",
              ),
            ),
            _StatCard(
              icon: AppAssets.checkIcon,
              data: "${habitProvider.getTotalDone()}",
              label: "Total done per day",
            ),
            _StatCard(
              icon: AppAssets.chartIcon,
              data: habitProvider.getLongestMissedHabitInfo(),
              label: "Long time not done",
            ),
            _StatCard(
              icon: Image.asset(AppAssets.averagePerDailyCardIcon),
              data: "${habitProvider.habits.length} ",
              label: "Habit Count",
            ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard(
      {required this.label, required this.icon, required this.data});
  final String label;
  final String data;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.largeBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPaddings.smallPaddingValue,
          vertical: AppPaddings.mediumPaddingValue,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// icon
              icon,
              const Gap(AppPaddings.smallPaddingValue),
              Text(
                data,
                style: context.textTheme.titleMedium?.copyWith(
                  color: AppColors.homeScaffoldColor,
                ),
              ),
              const Gap(AppPaddings.smallPaddingValue),

              /// label
              Text(
                label,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
