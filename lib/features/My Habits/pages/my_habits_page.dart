import 'package:flutter/material.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/features/home/widgets/i_drawer.dart';

import '../../../config/theme.dart';

class MyHabitsPage extends StatefulWidget {
  static const String routeName = "my habits";
  const MyHabitsPage({super.key});

  @override
  State<MyHabitsPage> createState() => _MyHabitsPageState();
}

class _MyHabitsPageState extends State<MyHabitsPage> {
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
          appBar: AppBar(
            centerTitle: true,
            title: const Text("My Habits"),
          ),
          body: Column(),
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
    );
  }
}
