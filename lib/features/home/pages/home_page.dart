import 'package:flutter/material.dart';
import 'package:good_place/core/constants/app_paddings.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/features/home/widgets/calendar_widget.dart';
import 'package:good_place/features/home/widgets/motivation_card_widget.dart';
import 'package:good_place/features/home/widgets/stat_grid_widget.dart';
import 'package:good_place/features/home/widgets/streak_card_widget.dart';
import 'package:good_place/logger.dart';

import '../../../config/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String appBarTitle = "Home Page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeScaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.homeScaffoldColor,
        foregroundColor: Colors.white,
        title: Text(
          appBarTitle,
        ),
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.homeScreenHorizontalPadding,
          child: const Column(
            children: [
              /// Calendar
              CalendarWidget(),

              /// Motivation Card
              MotivationCardWidget(),

              /// Streak Card
              StreakCardWidget(),

              /// Grid

              StatGridWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
