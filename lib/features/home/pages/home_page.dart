import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/features/home/widgets/my_habits_section.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_paddings.dart';
import '../widgets/calendar_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeScaffoldColor,
      floatingActionButton: fab(),
      appBar: appBar(),
      drawer: drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.homeScreenHorizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // WelcomeText
              WelcomeText(),

              /// Calendar
              CalendarWidget(),
              // Gap(AppPaddings.mediumPaddingValue),
              MyHabitsSection(),

              /// Motivation Card
              MotivationCardWidget(),
              Gap(AppPaddings.mediumPaddingValue),

              /// Streak Card
              StreakCardWidget(),
              Gap(AppPaddings.mediumPaddingValue),

              /// Grid
              StatGridWidget(),
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

  Drawer drawer() {
    return Drawer(
      /// TODO : bunu sil
      child: ElevatedButton(
        onPressed: () => FirebaseAuth.instance.signOut(),
        child: Text("Sign Out"),
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
