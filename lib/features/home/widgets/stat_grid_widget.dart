import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../config/theme.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_border_radius.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';

class StatGridWidget extends StatelessWidget {
  const StatGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppPaddings.smallPaddingValue,
        crossAxisSpacing: AppPaddings.smallPaddingValue,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        _StatCard(
          icon: AppAssets.calendarIcon,
          data: "1 Day",
          label: "Total perfect days",
        ),
        _StatCard(
          icon: AppAssets.checkIcon,
          data: "1 Day",
          label: "Total complete days",
        ),
        _StatCard(
          icon: AppAssets.chartIcon,
          data: "100%",
          label: "Habit completion rate",
        ),
        _StatCard(
          icon: Image.asset(AppAssets.averagePerDailyCardIcon),
          data: "1.01",
          label: "Average per daily",
        ),
      ],
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
    return FittedBox(
      fit: BoxFit.fill,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.largeBorderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPaddings.smallPaddingValue,
            vertical: AppPaddings.mediumPaddingValue,
          ),
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
