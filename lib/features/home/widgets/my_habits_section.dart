import 'package:flutter/material.dart';
import 'package:good_place/config/theme.dart';
import 'package:good_place/core/constants/app_assets.dart';
import 'package:good_place/core/constants/app_border_radius.dart';
import 'package:good_place/core/constants/app_paddings.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/core/utils/widgets/image_container.dart';

class MyHabitsSection extends StatelessWidget {
  const MyHabitsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Title Row
        titleRow(context),
        SizedBox(
          height: context.dynamicHeight(0.1),
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
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppPaddings.xxsmallPaddingValue,
      ),
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.smallBorderRadius,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            AppAssets.welcomePageImage,
          ),
        ),
      ),
      child: ColoredBox(
        color: AppColors.darkTextColor.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPaddings.xxsmallPaddingValue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Habit Name",
                    style: context.textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Checkbox(
                    value: false,
                    onChanged: (_) {},
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
