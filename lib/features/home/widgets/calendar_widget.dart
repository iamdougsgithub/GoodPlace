// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import '../../../core/utils/widgets/calendar.dart';
// import '../../../config/theme.dart';
// import '../../../core/constants/app_paddings.dart';
// import '../../../core/extensions/context_extension.dart';

// class CalendarWidget extends StatelessWidget {
//   const CalendarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.only(
//           left: AppPaddings.smallPaddingValue,
//           right: AppPaddings.smallPaddingValue,
//           bottom: AppPaddings.smallPaddingValue,
//         ),
//         child: Column(
//           children: [
//             /// Calendar
//             const Calendar(),
//             const Gap(AppPaddings.smallPaddingValue),

//             /// Text
//             calendarCardFooter(context)
//           ],
//         ),
//       ),
//     );
//   }

//   Row calendarCardFooter(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         // All Complete
//         Row(
//           children: [
//             const CircleAvatar(
//               radius: 4,
//               backgroundColor: AppColors.homeScaffoldColor,
//             ),
//             const Gap(4),
//             Text(
//               "All Complete",
//               style: context.textTheme.bodySmall,
//             ),
//           ],
//         ),
//         const Gap(AppPaddings.smallPaddingValue),
//         // Some Complete
//         Row(
//           children: [
//             Container(
//               width: 8,
//               height: 8,
//               decoration: const ShapeDecoration(
//                 shape: CircleBorder(
//                     side: BorderSide(
//                   width: 2,
//                   color: AppColors.homeScaffoldColor,
//                 )),
//               ),
//             ),
//             const Gap(4),
//             Text(
//               "Some Complete",
//               style: context.textTheme.bodySmall,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
