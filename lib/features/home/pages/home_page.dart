import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/core/utils/models/habit_model.dart';
import 'package:good_place/core/utils/widgets/add_habit_button.dart';
import 'package:good_place/features/user_data/habit_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/widgets/calendar.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/my_habits_section.dart';
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
  // late HabitProvider habitProvider;
  @override
  void initState() {
    Future.microtask(() => HabitProvider.instance.getHabits());

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    HabitProvider.instance = Provider.of<HabitProvider>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Theme(
        data: homePageThemeOverride(context),
        child: Scaffold(
          floatingActionButton: const AddHabitButton(),
          appBar: appBar(),
          drawer: IDrawer(
            context: context,
            selectedIndex: 0,
          ),
          body: RefreshIndicator(
            onRefresh: () async => await HabitProvider.instance.getHabits(),
            child: SingleChildScrollView(
              child: Padding(
                padding: AppPaddings.homeScreenHorizontalPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // WelcomeText
                    WelcomeText(),

                    /// Calendar
                    const HomeCalendarWidget(),
                    // Consumer<HabitProvider>(
                    //   builder: (context, provider, child) => Calendar(

                    //     eventLoader: (day) {
                    //       bool _isDone = false;

                    //       DateTime _day =
                    //           DateTime(day.year, day.month, day.day);
                    //       for (HabitModel habit in provider.habits) {
                    //         for (DateTime date in habit.completionDates) {
                    //           DateTime _date =
                    //               DateTime(date.year, date.month, date.day);
                    //           if (_date == _day) {
                    //             _isDone = true;
                    //           }
                    //         }
                    //       }
                    //       if (_isDone) {
                    //         return [const Text("data")];
                    //       }
                    //       return [];
                    //     },
                    //   ),
                    // ),
                    gap,

                    /// Motivation Card
                    const MotivationCardWidget(),
                    gap,
                    // My Habit Section
                    const MyHabitsSection(),
                    gap,

                    // /// Streak Card
                    // const StreakCardWidget(),
                    // gap,

                    /// Grid
                    const StatGridWidget(),

                    gap,
                  ]
                      .animate(interval: const Duration(milliseconds: 200))
                      .fadeIn(),
                ),
              ),
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
