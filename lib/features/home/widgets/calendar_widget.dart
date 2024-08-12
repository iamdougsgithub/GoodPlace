import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/packages/flutter_advanced_calendar/lib/flutter_advanced_calendar.dart';
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
          top: AppPaddings.largePaddingValue,
          left: AppPaddings.largePaddingValue,
          right: AppPaddings.largePaddingValue,
          bottom: AppPaddings.smallPaddingValue,
        ),
        child: Column(
          children: [
            const _Calendar(),
            const Gap(AppPaddings.smallPaddingValue),
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
            )
          ],
        ),
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
    return AdvancedCalendar(
      weekDaysStyle: context.textTheme.bodySmall,
      headerStyle: context.textTheme.labelLarge,
      todayStyle: context.textTheme.labelLarge,
      calendarTextStyle: context.textTheme.bodyMedium,
      startWeekDay: 1,
      innerDot: true,
      controller: controller,
      events: [
        DateTime(2024, 8, 11),
      ],
    );
  }
}
