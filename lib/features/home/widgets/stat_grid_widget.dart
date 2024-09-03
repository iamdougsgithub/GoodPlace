import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/resourcers/tutorial_manager.dart';
import 'package:good_place/core/utils/widgets/card_background_cover.dart';
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
            crossAxisCount: 3,
            mainAxisSpacing: AppPaddings.smallPaddingValue,
            crossAxisSpacing: AppPaddings.xxsmallPaddingValue,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            TutorialWidget(
              tutorialKey: TutorialKeys.statCard,
              child: _StatCard(
                icon: AppAssets.streakCardAnimation,
                data: "${habitProvider.getLongestStreak()}",
                label: "Longest streak",
              ),
            ),
            _StatCard(
              icon:
                  AppAssets.totalDonePerDayCardAnimation(height: 64, width: 64),
              data: "${habitProvider.getTotalDone()}",
              label: "Total done per day",
            ),
            _StatCard(
              icon:
                  AppAssets.longTimeNotDoneCardAnimation(width: 96, height: 96),
              data: habitProvider.getLongestMissedHabitInfo(),
              label: "Long time not done",
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
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: constraints.maxHeight * .8,
            width: constraints.maxWidth,
            child: Card(
              clipBehavior: Clip.antiAlias,
              color: AppColors.orangeTextColor,
              // shape:,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  /// Icon
                  Positioned(
                    right: 0,
                    top: 0,
                    child: icon,
                  ),

                  /// Data
                  CardBackgroundImageFilter(
                    opacity: 0.2,
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          data,
                          style: context.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FittedBox(
            child: Text(
              label,
              style: context.textTheme.labelLarge?.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );

    //  ClipRRect(
    //   borderRadius: AppBorderRadius.smallBorderRadius,
    //   child: GridTileBar(
    //     backgroundColor: AppColors.secondaryButtonColor,
    //     // dense: true,
    //     // dense: true,
    //     // tileColor: AppColors.authScaffoldColor,
    //     // leading: SizedBox(child: icon),
    //     subtitle: FittedBox(
    //       child: Center(
    //           child: Text(
    //         label,
    //         style: context.textTheme.labelLarge,
    //       )),
    //     ),
    //     title: Center(
    //       child: Text(
    //         data,
    //         style: context.textTheme.titleLarge,
    //         textAlign: TextAlign.center,
    //       ),
    //     ),
    //     trailing: icon,

    //     leading: icon,
    //   ),
    // );
  }
}
