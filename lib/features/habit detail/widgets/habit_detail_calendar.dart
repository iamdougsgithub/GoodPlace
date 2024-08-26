import 'package:flutter/material.dart';
import 'package:good_place/core/utils/widgets/calendar.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/utils/models/habit_model.dart';
import '../../user_data/habit_provider.dart';

class HabitDetailCalendar extends StatefulWidget {
  final int habitIndex;
  const HabitDetailCalendar({super.key, required this.habitIndex});

  @override
  State<HabitDetailCalendar> createState() => _HabitDetailCalendarState();
}

class _HabitDetailCalendarState extends State<HabitDetailCalendar> {
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
    return Consumer<HabitProvider>(
      builder: (context, provider, child) => _HabitDetailCalendar(
        context: context,
        focusedDay: currentDay,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            currentDay = selectedDay;
          });
        },
        eventLoader: (day) => eventLoader(day, provider),
      ),
    );
  }

  List<dynamic> eventLoader(DateTime day, HabitProvider provider) {
    bool isDone = false;

    DateTime formattedDay = DateTime(day.year, day.month, day.day);
    HabitModel habit = provider.habits[widget.habitIndex];

    for (var date in habit.completionDates) {
      DateTime formattedDate = DateTime(date.year, date.month, date.day);
      if (formattedDate == formattedDay) {
        isDone = true;
      }
    }

    if (isDone) {
      return [const SizedBox()];
    }
    return [];
  }
}

class _HabitDetailCalendar extends AppCalendar {
  _HabitDetailCalendar({
    required super.context,
    required super.focusedDay,
    super.onDaySelected,
    super.eventLoader,
  });
}
