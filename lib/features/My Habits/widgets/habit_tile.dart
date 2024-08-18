import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/utils/models/habit_model.dart';
import 'package:intl/intl.dart';
import '../../../core/extensions/context_extension.dart';

import '../../../config/theme.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_border_radius.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/utils/widgets/card_background_cover.dart';

class HabitTile extends StatelessWidget {
  final HabitModel habitModel;
  const HabitTile({super.key, required this.habitModel});

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
              image: habitModel.imageUrl != null &&
                      habitModel.imageUrl?.isEmpty == false
                  ? NetworkImage(habitModel.imageUrl ?? "")
                  : AssetImage(AppAssets.authTopBackgroundImage),
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
          habitModel.streakCount.toString(),
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
          habitModel.title,
          style: context.textTheme.titleMedium,
        ),
        Text(
          habitModel.purpose ?? "",
          style: context.textTheme.labelMedium,
        ),
        Gap(AppPaddings.smallPaddingValue),
        Text(
          DateFormat.yMMMEd().format(habitModel.createDate),
          style: context.textTheme.labelSmall,
        ),
      ],
    );
  }
}
