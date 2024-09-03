import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/constants/app_assets.dart';
import 'package:good_place/core/constants/app_border_radius.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/core/resourcers/tutorial_manager.dart';
import 'package:good_place/core/utils/widgets/add_habit_button.dart';
import 'package:good_place/core/utils/widgets/tutorial_widget.dart';
import 'package:good_place/features/AI%20chat/pages/ai_chat.dart';
import 'package:good_place/features/user_data/habit_provider.dart';
import 'package:provider/provider.dart';
import 'package:speech_balloon/speech_balloon.dart';
import 'package:toastification/toastification.dart';
import '../widgets/home_calendar_widget.dart';
import '../widgets/my_habits_section.dart';
import '../../../core/constants/app_paddings.dart';
import '../widgets/i_drawer.dart';
import '../widgets/motivation_card_widget.dart';
import '../widgets/stat_grid_widget.dart';

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
  void initState() {
    Future.microtask(
        () => Provider.of<HabitProvider>(context, listen: false).getHabits());
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return TutorialWrapper(
        autoPlay: !TutorialManager.ins.checkTutorialState(
          TutorialManager.homeTutorialKeList,
        ),
        child: Builder(builder: (context) {
          TutorialManager.ins.show(
            context,
            TutorialManager.homeTutorialKeList,
          );

          return PopScope(
            canPop: false,
            child: Theme(
              data: homePageThemeOverride(context),
              child: Scaffold(
                floatingActionButton: const TutorialWidget(
                  tutorialKey: TutorialKeys.createHabit,
                  child: AddHabitButton(),
                ),
                appBar: appBar(context),
                drawer: IDrawer(
                  context: context,
                  selectedIndex: 0,
                ),
                body: RefreshIndicator(
                  onRefresh: () async =>
                      await HabitProvider.instance.getHabits(),
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

                          gap,

                          /// Motivation Card
                          const TutorialWidget(
                              tutorialKey: TutorialKeys.motivationCard,
                              child: MotivationCardWidget()),
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
                          gap,
                          gap,
                        ]
                            .animate(
                                interval: const Duration(milliseconds: 200))
                            .fadeIn(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
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

  AppBar appBar(BuildContext ctx) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(32),
        child: Padding(
          padding: AppPaddings.homeScreenHorizontalPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SpeechBalloon(
                  borderRadius: AppBorderRadius.smallBorderRadiusValue,
                  nipLocation: NipLocation.top,
                  innerBorderRadius: 24,
                  width: 300,
                  child: Text(
                    "Good Nigtht Mustafa Emr Çelik . \nSana nasıl yardımcı olabilirim ?",
                    textAlign: TextAlign.end,
                  )),
            ],
          ),
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.homeScaffoldColor,
      foregroundColor: Colors.white,
      title: Text(
        appBarTitle,
      ),
      actions: [
        Padding(
          padding:
              const EdgeInsets.only(right: AppPaddings.xxsmallPaddingValue * 2),
          child: TutorialWidget(
            description: TutorialKeys.aiChat.tutorialDesc,
            tutorialKey: TutorialKeys.aiChat,
            child: GestureDetector(
              onTap: () => showModalBottomSheet(
                backgroundColor: AppColors.authScaffoldColor,
                showDragHandle: true,
                isScrollControlled: true,
                context: ctx,
                builder: (ctx) => const AIChat(),
              ),
              child: CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.orangeTextColor,
                child: AppAssets.aiIcon(256, 256),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
