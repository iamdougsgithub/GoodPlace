// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:good_place/core/constants/app_paddings.dart';
import 'package:good_place/core/extensions/context_extension.dart';

class StreakCardWidget extends StatelessWidget {
  const StreakCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(AppPaddings.mediumPaddingValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1 Day",
                style: context.textTheme.headlineMedium,
              ),
              Text(
                "Your current streak",
              ),
              Text(
                "1 Day",
                style: context.textTheme.labelLarge?.copyWith(
                  fontSize: 16,
                ),
              ),
              Text("Your longest streak"),
            ],
          ),
        ),
      ),
    );
  }
}
