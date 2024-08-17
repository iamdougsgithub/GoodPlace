import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/logger.dart';
import '../../../config/theme.dart';
import '../../constants/app_paddings.dart';
import '../../extensions/context_extension.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    super.key,
    this.eventLoader,
  });
  final List<dynamic> Function(DateTime)? eventLoader;
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppPaddings.smallPaddingValue,
          right: AppPaddings.smallPaddingValue,
          bottom: AppPaddings.smallPaddingValue,
        ),
        child: Column(
          children: [
            TableCalendar(
              focusedDay: DateTime(2024, 8, 6),
              startingDayOfWeek: StartingDayOfWeek.monday,
              firstDay: DateTime(2000),
              lastDay: DateTime(2050),

              /// TODO : Burayı Provider'den al
              eventLoader: (day) {
                List d = [
                  DateTime(2024, 08, 13, 00, 00, 00, 00, 000).toString()
                ];
                logger.i(d);
                if (d.contains(day.toString())) {
                  return [Text("data")];
                }
                return [];
              }, //widget.eventLoader,

              onDayLongPressed: (selectedDay, focusedDay) {},

              calendarBuilders: calendarBuilder(),
              onDaySelected: onDaySelected,
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
                CalendarFormat.week: 'Week',
              },
              calendarFormat: calendarFormat,
              headerStyle: headerStyle(context),
              calendarStyle: calendarStyle(),

              onFormatChanged: onFormatChanged,
              currentDay: focusedDay,
            ),

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

  CalendarStyle calendarStyle() => const CalendarStyle(
        defaultTextStyle: TextStyle(
            // foreground: Paint()..color = Colors.red,
            ),
      );

  void onFormatChanged(format) {
    setState(() {
      calendarFormat = format;
    });
  }

  void onDaySelected(selectedDay, a) {
    setState(() {
      focusedDay = selectedDay;
    });
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
