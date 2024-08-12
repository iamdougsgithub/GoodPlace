import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:gap/gap.dart';
import 'package:good_place/config/theme.dart';
import 'package:good_place/core/constants/app_paddings.dart';
import 'package:good_place/core/extensions/context_extension.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const _Calendar(),
          Row(
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
                  const Text("All Complete"),
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
                  Text("Some Complete"),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _Calendar extends StatefulWidget {
  const _Calendar();

  @override
  State<_Calendar> createState() => __CalendarState();
}

class __CalendarState extends State<_Calendar> {
  AdvancedCalendarController controller = AdvancedCalendarController.today();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPaddings.largePaddingValue),
      child: AdvancedCalendar(
        headerStyle: context.textTheme.labelLarge,
        todayStyle: context.textTheme.labelLarge,
        calendarTextStyle: context.textTheme.bodyLarge,
        startWeekDay: 1,
        innerDot: true,
        controller: controller,
        events: [
          DateTime(2024, 8, 11),
        ],
      ),
    );
  }
}
