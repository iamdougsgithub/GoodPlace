import 'package:flutter/material.dart';
import '../../../core/utils/widgets/card_background_cover.dart';
import '../../../core/constants/app_border_radius.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
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

  /// TODO : [habitName] ve [habitImageUrl] Firestore'dan al
  final String habitName = "Habit Name";
  final String habitImageUrl =
      "https://images.unsplash.com/photo-1518655048521-f130df041f66?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
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
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              habitImageUrl,
            ),
          ),
        ),
        child: CardBackgroundImageFilter(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPaddings.xxsmallPaddingValue,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    habitName,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  value: false,
                  onChanged: (_) {
                    logger.i("message");
                  },
                ),
              )),
        ),
      ),
    );
  }
}
