// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:good_place/features/home/pages/home_page.dart';
import 'package:good_place/features/user_data/habit_provider.dart';
import 'package:good_place/logger.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/widgets/add_habit_button.dart';
import '../../home/widgets/i_drawer.dart';

import '../../../config/theme.dart';
import '../widgets/habit_tile.dart';

class MyHabitsPage extends StatefulWidget {
  static const String routeName = "my habits";
  const MyHabitsPage({super.key});

  @override
  State<MyHabitsPage> createState() => _MyHabitsPageState();
}

class _MyHabitsPageState extends State<MyHabitsPage> {
  final String pageTitle = "My Habits";

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        context.pushReplacementNamed(HomePage.routeName);
      },
      child: Theme(
        data: myHabitsThemeOverride(context),
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            drawer: IDrawer(
              context: context,
              selectedIndex: 1,
            ),
            floatingActionButton: AddHabitButton(),
            appBar: AppBar(
              centerTitle: true,
              title: Text(pageTitle),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: AppAssets.sortIcon,
                )
              ],
            ),
            body: Padding(
              padding: AppPaddings.homeScreenHorizontalPadding,
              child: Consumer<HabitProvider>(
                builder: (context, provider, child) => ListView.builder(
                  itemCount: provider.habits.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppPaddings.smallPaddingValue,
                      ),
                      child: HabitTile(
                        // habitModel: provider.habits[index],
                        index: index,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  ThemeData myHabitsThemeOverride(BuildContext context) {
    return context.theme.copyWith(
      scaffoldBackgroundColor: AppColors.homeScaffoldColor,
      appBarTheme: context.theme.appBarTheme.copyWith(
        color: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      textTheme: context.textTheme.copyWith(
        titleMedium: context.textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontSize: 16,
        ),
        titleSmall: context.textTheme.titleSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color(0x4C000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        labelMedium: context.textTheme.labelMedium?.copyWith(
          color: Colors.white,
        ),
        labelSmall: context.textTheme.labelMedium?.copyWith(
          color: Colors.white.withOpacity(0.75),
        ),
        headlineLarge: context.textTheme.headlineLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color(0x4C000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
      ),
    );
  }
}
