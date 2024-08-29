import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/resourcers/tutorial_manager.dart';
import 'package:good_place/core/utils/widgets/tutorial_widget.dart';
import 'package:good_place/logger.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../config/theme.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/models/habit_model.dart';
import '../../../core/utils/widgets/calendar.dart';
import '../../user_data/habit_provider.dart';

class HomeCalendarWidget extends StatefulWidget {
  const HomeCalendarWidget({super.key});

  @override
  State<HomeCalendarWidget> createState() => _HomeCalendarWidgetState();
}

class _HomeCalendarWidgetState extends State<HomeCalendarWidget> {
  late DateTime currentDay;
  late CalendarFormat calendarFormat;
  @override
  void initState() {
    currentDay = DateTime.now();
    calendarFormat = CalendarFormat.month;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TutorialWidget(
      description: TutorialKeys.calendar.tutorialDesc,
      tutorialKey: TutorialKeys.calendar,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppPaddings.smallPaddingValue,
            right: AppPaddings.smallPaddingValue,
            bottom: AppPaddings.smallPaddingValue,
          ),
          child: Column(
            // key: a,
            children: [
              /// Calendar
              Consumer<HabitProvider>(
                builder: (context, provider, child) => _HomeCalendar(
                  calendarFormat: calendarFormat,
                  eventLoader: (day) => eventLoader(day, provider),
                  context: context,
                  focusedDay: currentDay,
                  onDaySelected: (selectedDay, focusedDay) {
                    onLongPressed(selectedDay, focusedDay, provider);
                    setState(() {
                      currentDay = selectedDay;
                    });
                  },
                  onFormatChanged: (format) => setState(() {
                    calendarFormat = format;
                  }),
                ),
              ),
              const Gap(AppPaddings.smallPaddingValue),

              /// Text
              calendarCardFooter(context)
            ],
          ),
        ),
      ),
    );
  }

  void onLongPressed(
      DateTime selectedDay, DateTime focusedDay, HabitProvider provider) {
    DateTime formattedSelectedDay =
        DateTime(selectedDay.year, selectedDay.month, selectedDay.day);

    List<HabitModel> completedHabitsList = [];

    provider.habits.forEach((habit) {
      for (var date in habit.completionDates) {
        date = DateTime(date.year, date.month, date.day);
        if (date == formattedSelectedDay) {
          completedHabitsList.add(habit);
        }
      }
    });
    if (completedHabitsList.isNotEmpty) {
      showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(
          maxHeight: context.dynamicHeight(0.6),
        ),
        isScrollControlled: true,
        enableDrag: true,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(AppPaddings.smallPaddingValue),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Habits",
                    style: context.textTheme.labelLarge,
                  ),
                  Text(provider.habits.length.toString()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Completed Habits",
                    style: context.textTheme.labelLarge,
                  ),
                  Text(completedHabitsList.length.toString()),
                ],
              ),
              const Divider(),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: completedHabitsList.map((habit) {
                    return ListTile(
                      title: Text(habit.title),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  List<dynamic> eventLoader(DateTime day, HabitProvider provider) {
    bool is_there = false;

    DateTime _day = DateTime(day.year, day.month, day.day);

    is_there = HabitProvider.instance.allCompletionDates.contains(_day);

    if (is_there) {
      return [const Text("data")];
    }
    return [];
  }

  Row calendarCardFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // All Complete
        Row(
          children: [
            const CircleAvatar(
              radius: 4,
              backgroundColor: AppColors.homeScaffoldColor,
            ),
            const Gap(4),
            Text(
              "All Complete",
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
        const Gap(AppPaddings.smallPaddingValue),
        // Some Complete
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const ShapeDecoration(
                shape: CircleBorder(
                    side: BorderSide(
                  width: 2,
                  color: AppColors.homeScaffoldColor,
                )),
              ),
            ),
            const Gap(4),
            Text(
              "Some Complete",
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}

class _HomeCalendar extends AppCalendar {
  _HomeCalendar({
    required super.context,
    super.onDaySelected,
    super.onFormatChanged,
    super.calendarFormat,
    required super.focusedDay,
    super.eventLoader,
    super.onDayLongPressed,
  });
}
