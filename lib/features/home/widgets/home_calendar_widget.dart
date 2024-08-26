import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/features/habit%20detail/pages/habit_detail.dart';
import 'package:good_place/features/user_data/habit_provider.dart';
import 'package:good_place/logger.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/utils/models/habit_model.dart';
import '../../../core/utils/widgets/calendar.dart';
import '../../../config/theme.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';

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
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppPaddings.smallPaddingValue,
          right: AppPaddings.smallPaddingValue,
          bottom: AppPaddings.smallPaddingValue,
        ),
        child: Column(
          children: [
            /// Calendar
            Consumer<HabitProvider>(
              builder: (context, provider, child) => _HomeCalendar(
                calendarFormat: calendarFormat,
                eventLoader: (day) => eventLoader(day, provider),
                onDayLongPressed: (selectedDay, focusedDay) =>
                    onLongPressed(selectedDay, focusedDay, provider),
                context: context,
                focusedDay: currentDay,
                onDaySelected: (selectedDay, focusedDay) {
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
    );
  }

  void onLongPressed(
      DateTime selectedDay, DateTime focusedDay, HabitProvider provider) {
    DateTime _selectedDay =
        DateTime(selectedDay.year, selectedDay.month, selectedDay.day);

    List<HabitModel> _habits = [];

    provider.habits.forEach((habit) {
      for (var date in habit.completionDates) {
        date = DateTime(date.year, date.month, date.day);
        if (date == _selectedDay) {
          _habits.add(habit);
        }
      }
    });
    showModalBottomSheet(
      context: context,
      builder: (context) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: context.dynamicHeight(0.5),
          minHeight: context.dynamicHeight(0.3),
        ),
        child: ListView(
          shrinkWrap: true,
          children: _habits.map((habit) {
            return ListTile(
              onTap: () => context.pushNamed(
                HabitDetail.routeName,
              ),
              title: Text(habit.title),
            );
          }).toList(),
        ),
      ),
    );
  }

  List<dynamic> eventLoader(DateTime day, HabitProvider provider) {
    bool _isDone = false;

    DateTime _day = DateTime(day.year, day.month, day.day);
    for (HabitModel habit in provider.habits) {
      for (DateTime date in habit.completionDates) {
        DateTime _date = DateTime(date.year, date.month, date.day);
        if (_date == _day) {
          _isDone = true;
        }
      }
    }
    if (_isDone) {
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
