import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/extensions/context_extension.dart';
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
  static const routeName = "home";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String appBarTitle = "Home";
  static const Gap gap = Gap(AppPaddings.smallPaddingValue);
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: homePageThemeOverride(context),
      child: Scaffold(
        floatingActionButton: fab(),
        appBar: appBar(),
        drawer: IDrawer(
          context: context,
          selectedIndex: 0,
        ),
        body: SingleChildScrollView(
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
                // My Habit Section
                MyHabitsSection(),
                gap,

                /// Streak Card
                StreakCardWidget(),
                gap,

                /// Grid
                StatGridWidget(),

                gap,
              ],
            ),
          ),
        ),
      ),
    );
  }

  ThemeData homePageThemeOverride(BuildContext context) {
    return context.theme.copyWith(
      scaffoldBackgroundColor: AppColors.homeScaffoldColor,
      appBarTheme: context.theme.appBarTheme.copyWith(
        color: Colors.transparent,
        foregroundColor: Colors.white,
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
