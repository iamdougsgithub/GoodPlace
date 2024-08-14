import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/utils/widgets/calendar.dart';
import '../widgets/my_habits_section.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_paddings.dart';
import '../widgets/i_drawer.dart';
import '../widgets/motivation_card_widget.dart';
import '../widgets/stat_grid_widget.dart';
import '../widgets/streak_card_widget.dart';

import '../../../config/theme.dart';
import '../widgets/welcome_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String appBarTitle = "Home";
  static const Gap gap = Gap(AppPaddings.smallPaddingValue);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeScaffoldColor,
      floatingActionButton: fab(),
      appBar: appBar(),
      drawer: IDrawer(context: context),
      body: const SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.homeScreenHorizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // WelcomeText
              WelcomeText(),

              /// Calendar
              Calendar(),
              gap,

              /// Motivation Card
              MotivationCardWidget(),

              gap,

              /// Streak Card
              StreakCardWidget(),
              gap,

              /// Grid
              StatGridWidget(),

              gap,
              // My Habit Section
              MyHabitsSection(),
              gap,
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton fab() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: AppColors.primaryButtonColor,
      child: AppAssets.fabAddIcon,
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.homeScaffoldColor,
      foregroundColor: Colors.white,
      title: Text(
        appBarTitle,
      ),
    );
  }
}
