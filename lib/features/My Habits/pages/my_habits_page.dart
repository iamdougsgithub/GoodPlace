import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_place/core/constants/app_assets.dart';
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: AppColors.primaryButtonColor,
            foregroundColor: AppColors.secondaryButtonColor,
            child: AppAssets.fabAddIcon,
          ),
          appBar: AppBar(
            centerTitle: true,
            title: const Text("My Habits"),
          ),
          body: Column(
            children: [
              ListTile(),
              Dismissible(
                key: ValueKey(0),
                child: Text("data"),
              ),
            ],
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
    );
  }
}
