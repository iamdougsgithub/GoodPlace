import 'package:flutter/material.dart';
import 'package:good_place/core/constants/app_assets.dart';
import '../../extensions/context_extension.dart';
import 'package:table_calendar/table_calendar.dart';

abstract class AppCalendar extends TableCalendar {
  final BuildContext context;
  AppCalendar({
    super.key,
    required this.context,
    super.eventLoader,
    super.onDayLongPressed,
    super.onDaySelected,
    super.onFormatChanged,
    super.calendarFormat,
    required super.focusedDay,
  }) : super(
          firstDay: DateTime(2000),
          lastDay: DateTime(2050),
          currentDay: focusedDay,
        );

  @override
  CalendarStyle get calendarStyle => const CalendarStyle(
        // markerDecoration: ,
        defaultTextStyle: TextStyle(
            // foreground: Paint()..color = Colors.red,
            ),
      );

  @override
  HeaderStyle get headerStyle => HeaderStyle(
        leftChevronPadding: EdgeInsets.zero,
        rightChevronPadding: EdgeInsets.zero,
        rightChevronMargin: EdgeInsets.zero,
        leftChevronMargin: EdgeInsets.zero,
        titleTextStyle: context.textTheme.labelLarge ?? const TextStyle(),
      );

  @override
  StartingDayOfWeek get startingDayOfWeek => StartingDayOfWeek.monday;

  @override
  Map<CalendarFormat, String> get availableCalendarFormats => const {
        CalendarFormat.month: 'Month',
        CalendarFormat.week: 'Week',
      };

  @override
  CalendarBuilders get calendarBuilders => CalendarBuilders(
        markerBuilder: (context, day, events) {
          if (events.isNotEmpty) {
            return AppAssets.totalDonePerDayCardAnimation(
                width: 24, height: 24);
          }
          return null;
        },
        defaultBuilder: (context, day, focusedDay) {
          return Column(
            children: [
              Text(
                day.day.toString(),
                style: context.textTheme.labelSmall,
              ),
            ],
          );
        },
        todayBuilder: (context, day, focusedDay) {
          return Column(
            children: [
              CircleAvatar(
                child: Text(
                  day.day.toString(),
                  style: context.textTheme.labelLarge,
                ),
              ),
            ],
          );
        },
      );
}
