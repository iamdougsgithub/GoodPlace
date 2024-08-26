import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/constants/app_assets.dart';
import 'package:good_place/core/constants/app_paddings.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/core/utils/models/habit_model.dart';
import 'package:good_place/core/utils/widgets/card_background_cover.dart';
import 'package:good_place/features/habit%20detail/widgets/habit_detail_calendar.dart';
import 'package:good_place/features/habit%20detail/widgets/habit_detail_motivation.dart';
import 'package:good_place/features/home/widgets/motivation_card_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../config/theme.dart';
import '../../../core/utils/widgets/custom_toast.dart';
import '../../user_data/habit_provider.dart';

class HabitDetail extends StatefulWidget {
  static const routeName = "habit-detail";
  const HabitDetail({
    super.key,
  });

  @override
  State<HabitDetail> createState() => _HabitDetailState();
}

class _HabitDetailState extends State<HabitDetail> {
  @override
  Widget build(BuildContext context) {
    HabitProvider habitProvider = Provider.of<HabitProvider>(context);

    final int habitIndex = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: fab(habitProvider, habitIndex, context),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            _pageHeader(context, habitProvider, habitIndex),
            HabitDetailMotivation(
              habitDetail: habitProvider.habits[habitIndex].toString(),
            ),
            HabitDetailCalendar(
              habitIndex: habitIndex,
            ),
            const Gap(
                AppPaddings.largePaddingValue + AppPaddings.smallPaddingValue),
          ],
        ),
      ),
    );
  }

  SizedBox _pageHeader(
      BuildContext context, HabitProvider habitProvider, int habitIndex) {
    return SizedBox(
      height: context.dynamicHeight(0.4),
      width: double.infinity,
      child: Stack(
        children: [
          _image(context, habitProvider.habits[habitIndex]),

          CardBackgroundImageFilter(
            child: SizedBox(
              height: context.dynamicHeight(0.4),
              width: double.infinity,
            ),
          ),

          _infoRow(habitProvider.habits[habitIndex], context),

          /// Streak Count
          _streakCount(habitProvider.habits[habitIndex], context),
        ],
      ),
    );
  }

  FloatingActionButton fab(
      HabitProvider habitProvider, int habitIndex, BuildContext context) {
    return FloatingActionButton(
        backgroundColor: AppColors.primaryButtonColor,
        child: AppAssets.checkIcon,
        onPressed: () {
          if (!habitProvider.habits[habitIndex].done) {
            Provider.of<HabitProvider>(context, listen: false)
                .updateHabit(habitProvider.habits[habitIndex].id ?? "");
            Toast.wellDone();
          } else {
            null;
          }
        });
  }

  Widget _image(BuildContext context, HabitModel habitModel) {
    return habitModel.imageUrl == null || habitModel.imageUrl!.isEmpty
        ? Image.asset(AppAssets.authTopBackgroundImage)
        : Image.network(
            habitModel.imageUrl ?? "",
            fit: BoxFit.cover,
            height: context.dynamicHeight(0.4),
          ).animate().shimmer();
  }

  Widget _streakCount(HabitModel habitModel, BuildContext context) {
    return Positioned(
      right: AppPaddings.smallPaddingValue,
      top: kToolbarHeight,
      child: Column(children: [
        Column(
          children: [
            Text(
              habitModel.streakCount.toString(),
              style: context.textTheme.headlineLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Streak",
              style: context.textTheme.titleSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              habitModel.longestStreak.toString(),
              style: context.textTheme.headlineLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Longest\nStreak",
              style: context.textTheme.titleSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ]),
    );
  }

  Positioned _infoRow(HabitModel habitModel, BuildContext context) {
    return Positioned(
      left: AppPaddings.homeScreenHorizontalPadding.left,
      bottom: AppPaddings.homeScreenHorizontalPadding.bottom,
      right: AppPaddings.homeScreenHorizontalPadding.right,
      child: LayoutBuilder(
        builder: (context, constraints) => FittedBox(
          fit: BoxFit.contain,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight,
                  maxWidth: constraints.maxWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    Text(
                      habitModel.title,
                      style: context.textTheme.titleLarge
                          ?.copyWith(color: Colors.white),
                    ),

                    /// Purpose
                    Visibility(
                        visible: habitModel.purpose != "",
                        child: Markdown(
                          data: habitModel.purpose ?? "",
                          shrinkWrap: true,
                          styleSheet: MarkdownStyleSheet(
                              p: context.textTheme.labelLarge
                                  ?.copyWith(color: Colors.white)),
                        )

                        // Text(
                        //   habitModel.purpose ?? "",
                        //   style: context.textTheme.labelLarge
                        //       ?.copyWith(color: Colors.white),
                        // ),
                        ),
                  ],
                ),
              ),
              Gap(constraints.maxWidth / 2),

              /// Created Date
              Text(
                DateFormat.yMMMEd().format(habitModel.createDate),
                style: context.textTheme.labelLarge?.copyWith(
                  color: Colors.white.withOpacity(
                    0.75,
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(),
      ),
    );
  }
}
