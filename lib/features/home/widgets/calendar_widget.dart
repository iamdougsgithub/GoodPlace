import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/logger.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../config/theme.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          // top: AppPaddings.largePaddingValue,
          left: AppPaddings.smallPaddingValue,
          right: AppPaddings.smallPaddingValue,
          bottom: AppPaddings.smallPaddingValue,
        ),
        child: Column(
          children: [
            /// Calendar

            const _Calendar(),
            const Gap(AppPaddings.smallPaddingValue),

            /// Text
            calendarCardFooter(context)
          ],
        ),
      ),
    );
  }

  Row calendarCardFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: AppColors.homeScaffoldColor,
              ),
            ),
            const Gap(4),
            Text(
              "All Complete",
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
        const Gap(AppPaddings.smallPaddingValue),
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

class _Calendar extends StatefulWidget {
  const _Calendar();

  @override
  State<_Calendar> createState() => __CalendarState();
}

class __CalendarState extends State<_Calendar> {
  late DateTime today;
  late DateTime focusedDay;
  CalendarFormat calendarFormat = CalendarFormat.month;
  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    focusedDay = today;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime(2024, 8, 6),
      startingDayOfWeek: StartingDayOfWeek.monday,
      firstDay: DateTime(2000),
      lastDay: DateTime(2050),

      /// TODO : Burayı firebase'den al
      eventLoader: (day) {
        return [
          // Text("a"),
        ];
      },

      onDayLongPressed: (selectedDay, focusedDay) {},

      /// Builders
      ///
      calendarBuilders: calendarBuilder(),
      onDaySelected: (selectedDay, a) {
        setState(() {
          focusedDay = selectedDay;
        });
      },
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        CalendarFormat.week: 'Week',
      },
      calendarFormat: calendarFormat,
      headerStyle: headerStyle(context),
      calendarStyle: const CalendarStyle(
        defaultTextStyle: TextStyle(
            // foreground: Paint()..color = Colors.red,
            ),
      ),

      onFormatChanged: (format) {
        logger.i(format);
        setState(() {
          calendarFormat = format;
        });
      },
      currentDay: focusedDay,
    );
  }

  HeaderStyle headerStyle(BuildContext context) {
    return HeaderStyle(
      leftChevronPadding: EdgeInsets.zero,
      rightChevronPadding: EdgeInsets.zero,
      rightChevronMargin: EdgeInsets.zero,
      leftChevronMargin: EdgeInsets.zero,
      titleTextStyle: context.textTheme.labelLarge ?? const TextStyle(),
    );
  }

  CalendarBuilders<dynamic> calendarBuilder() {
    return CalendarBuilders(
      defaultBuilder: (context, day, focusedDay) {
        return Text(
          day.day.toString(),
          style: context.textTheme.labelSmall,
        );
      },
      todayBuilder: (context, day, focusedDay) {
        return CircleAvatar(
          child: Text(
            day.day.toString(),
            style: context.textTheme.labelLarge,
          ),
        );
      },
    );
  }
}
