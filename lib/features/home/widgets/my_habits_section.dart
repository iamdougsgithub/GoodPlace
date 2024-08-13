import 'package:flutter/material.dart';
import 'package:good_place/config/theme.dart';
import 'package:good_place/core/constants/app_border_radius.dart';
import 'package:good_place/core/constants/app_paddings.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/logger.dart';

class MyHabitsSection extends StatelessWidget {
  const MyHabitsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Title Row
        titleRow(context),
        SizedBox(
          height: context.dynamicHeight(0.15),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              _HabitCard(),
              _HabitCard(),
              _HabitCard(),
            ],
          ),
        ),
      ],
    );
  }

  Row titleRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Title
        Text(
          "My Habits",
          style: context.textTheme.titleMedium?.copyWith(
            color: Colors.white,
          ),
        ),

        /// See All button
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(),
          child: Text(
            "See All",
            style: context.textTheme.labelLarge?.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _HabitCard extends StatelessWidget {
  const _HabitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(
          horizontal: AppPaddings.xxsmallPaddingValue,
        ),
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.smallBorderRadius,

          /// TODO : burası değişecek
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              "https://plus.unsplash.com/premium_photo-1665990294432-c4baf9088c50?q=80&w=2938&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            ),
          ),
        ),
        child: ColoredBox(
          color: AppColors.darkTextColor.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(
              AppPaddings.xxsmallPaddingValue,
            ),
            child: CheckboxMenuButton(
              style: const ButtonStyle(
                  alignment: Alignment.bottomCenter,
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity()),
              value: false,
              onChanged: (_) {
                logger.i("asdad");
              },

              /// Habit name
              child: FittedBox(
                child: Text(
                  "Habit Name",
                  style: context.textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
