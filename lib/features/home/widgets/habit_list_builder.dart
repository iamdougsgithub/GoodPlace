import 'package:flutter/material.dart';
import 'package:good_place/core/utils/models/habit_model.dart';

class HabitListBuilder extends StatelessWidget {
  final List<HabitModel>? habitList;
  final Widget child;
  final Axis scrollDirection;
  const HabitListBuilder({
    super.key,
    this.habitList,
    required this.child,
    this.scrollDirection = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: habitList?.length,
        scrollDirection: scrollDirection,
        itemBuilder: (context, index) {
          return child;
        });
  }
}
