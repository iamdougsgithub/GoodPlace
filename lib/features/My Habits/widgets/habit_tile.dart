import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/utils/models/habit_model.dart';
import 'package:good_place/features/habit%20detail/pages/habit_detail.dart';
import 'package:good_place/features/user_data/habit_provider.dart';
// ignore: unused_import
import 'package:good_place/logger.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/extensions/context_extension.dart';

import '../../../config/theme.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_border_radius.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/utils/widgets/card_background_cover.dart';

class HabitTile extends StatelessWidget {
  final int index;
  const HabitTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    HabitProvider habitProvider = Provider.of<HabitProvider>(context);
    HabitModel habitModel = habitProvider.habits[index];
    return GestureDetector(
      onTap: () => context.navigator.pushNamed(
        HabitDetail.routeName,
        arguments: index,
      ),
      child: ClipRRect(
        borderRadius: AppBorderRadius.smallBorderRadius,
        child: Slidable(
          key: ValueKey(habitModel.id),
          startActionPane: checkButton(habitModel, habitProvider),
          endActionPane: deleteButton(habitModel),
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
                contentPadding: const EdgeInsets.symmetric(
                  vertical: AppPaddings.mediumPaddingValue,
                  horizontal: AppPaddings.smallPaddingValue,
                ),
                title: LayoutBuilder(builder: (context, c) {
                  return FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        contentColumn(context, habitModel),
                        Gap(c.maxWidth / 2),
                        streakColumn(context, habitModel),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ActionPane deleteButton(HabitModel habitModel) {
    return ActionPane(
      motion: Container(
        color: AppColors.errDark,
        child: IconButton(
          onPressed: () =>
              HabitProvider.instance.deleteHabit(habitModel.id ?? ""),
          icon: AppAssets.removeIcon,
        ),
      ),
      extentRatio: 0.3,
      children: [],
    );
  }

  ActionPane checkButton(HabitModel habitModel, HabitProvider habitProvider) {
    return ActionPane(
      motion: Container(
        color: AppColors.succDark,
        child: IconButton(
          onPressed: () {
            if (!habitModel.done) {
              habitProvider.updateHabit(habitModel.id ?? "");
            }
          },
          icon: AppAssets.checkIcon,
        ),
      ),
      extentRatio: 0.3,
      children: [],
    );
  }

  Column streakColumn(BuildContext context, HabitModel habitModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
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

  Column contentColumn(BuildContext context, HabitModel habitModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
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
