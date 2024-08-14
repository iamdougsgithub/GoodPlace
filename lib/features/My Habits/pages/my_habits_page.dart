// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_border_radius.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/widgets/card_background_cover.dart';
import '../../home/widgets/i_drawer.dart';

import '../../../config/theme.dart';

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
    return Theme(
      data: myHabitsThemeOverride(context),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          drawer: IDrawer(
            context: context,
            selectedIndex: 1,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: AppColors.primaryButtonColor,
            foregroundColor: AppColors.secondaryButtonColor,
            child: AppAssets.fabAddIcon,
          ),
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
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: AppPaddings.smallPaddingValue),
                  child: HabitTile(),
                );
              },
            ),
          ),
        );
      }),
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

class HabitTile extends StatelessWidget {
  const HabitTile({super.key});
  final String streakCount = "5";
  final String habitName = "Drink Water";
  final String habitPurpose = "Lorem ipsum dolor sit amet consectetur.";
  final String habitCreatedDate = "14.08.24";

  final String imgUrl =
      "https://plus.unsplash.com/premium_photo-1665990294432-c4baf9088c50?q=80&w=2938&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppBorderRadius.smallBorderRadius,
      child: Slidable(
        startActionPane: checkButton(),
        endActionPane: deleteButton(),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imgUrl),
            ),
          ),
          child: CardBackgroundImageFilter(
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: AppPaddings.mediumPaddingValue,
                horizontal: AppPaddings.smallPaddingValue,
              ),
              title: FittedBox(
                fit: BoxFit.fitHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    contentColumn(context),
                    Gap(AppPaddings.largePaddingValue),
                    streakColumn(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ActionPane deleteButton() {
    return ActionPane(
      motion: Container(
        color: AppColors.errDark,
        child: IconButton(
          onPressed: () {},
          icon: AppAssets.removeIcon,
        ),
      ),
      extentRatio: 0.3,
      children: [],
    );
  }

  ActionPane checkButton() {
    return ActionPane(
      motion: Container(
        color: AppColors.succDark,
        child: IconButton(
          onPressed: () {},
          icon: AppAssets.checkIcon,
        ),
      ),
      extentRatio: 0.3,
      children: [],
    );
  }

  Column streakColumn(BuildContext context) {
    return Column(
      children: [
        Text(
          streakCount,
          style: context.textTheme.headlineLarge,
        ),
        Text(
          "Streak",
          style: context.textTheme.titleSmall,
        ),
      ],
    );
  }

  Column contentColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          habitName,
          style: context.textTheme.titleMedium,
        ),
        Text(
          habitPurpose,
          style: context.textTheme.labelMedium,
        ),
        Text(
          habitCreatedDate,
          style: context.textTheme.labelSmall,
        ),
      ],
    );
  }
}
