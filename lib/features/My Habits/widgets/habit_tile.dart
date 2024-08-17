import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import '../../../core/extensions/context_extension.dart';

import '../../../config/theme.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_border_radius.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/utils/widgets/card_background_cover.dart';

class HabitTile extends StatelessWidget {
  const HabitTile({super.key});
  final String streakCount = "5";
  final String habitName = "Drink Water";
  final String habitPurpose = "Lorem ipsum dolor sit amet consectetur.";
  final String habitCreatedDate = "14.08.24";

  final String imgUrl =
      "https://plus.unsplash.com/premium_photo-1665990294432-c4baf9088c50?q=80&w=2938&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppBorderRadius.smallBorderRadius,
      child: Slidable(
        startActionPane: checkButton(),
        endActionPane: deleteButton(),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imgUrl),
            ),
          ),
          child: CardBackgroundImageFilter(
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: AppPaddings.mediumPaddingValue,
                horizontal: AppPaddings.smallPaddingValue,
              ),
              title: FittedBox(
                fit: BoxFit.fitHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    contentColumn(context),
                    const Gap(AppPaddings.largePaddingValue),
                    streakColumn(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ActionPane deleteButton() {
    return ActionPane(
      motion: Container(
        color: AppColors.errDark,
        child: IconButton(
          onPressed: () {},
          icon: AppAssets.removeIcon,
        ),
      ),
      extentRatio: 0.3,
      children: [],
    );
  }

  ActionPane checkButton() {
    return ActionPane(
      motion: Container(
        color: AppColors.succDark,
        child: IconButton(
          onPressed: () {},
          icon: AppAssets.checkIcon,
        ),
      ),
      extentRatio: 0.3,
      children: [],
    );
  }

  Column streakColumn(BuildContext context) {
    return Column(
      children: [
        Text(
          streakCount,
          style: context.textTheme.headlineLarge,
        ),
        const Gap(AppPaddings.smallPaddingValue),
        Text(
          "Streak",
          style: context.textTheme.titleSmall,
        ),
      ],
    );
  }

  Column contentColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          habitName,
          style: context.textTheme.titleMedium,
        ),
        Text(
          habitPurpose,
          style: context.textTheme.labelMedium,
        ),
        Gap(AppPaddings.smallPaddingValue),
        Text(
          habitCreatedDate,
          style: context.textTheme.labelSmall,
        ),
      ],
    );
  }
}
