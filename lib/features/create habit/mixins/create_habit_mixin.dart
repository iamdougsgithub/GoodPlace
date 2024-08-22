import 'package:flutter/material.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:provider/provider.dart';

import '../../../config/theme.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/utils/models/habit_model.dart';
import '../../habit detail/pages/habit_detail.dart';
import '../../user_data/habit_provider.dart';
import '../pages/create_habit_page.dart';

mixin CreateHabitMixin on State<CreateHabitPage> {
  final TextEditingController habitNameController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final String appBarTitle = "Create Your Habit";
  final String habitNameTextFieldLabel = "Habit Name";
  final String habitPurposeTextFieldLabel = "My purpose";
  @override
  void dispose() {
    habitNameController.dispose();
    imageUrlController.dispose();
    purposeController.dispose();
    super.dispose();
  }

  Row fab() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: AppPaddings.homeScreenHorizontalPadding,
            child: FloatingActionButton.extended(
              backgroundColor: AppColors.primaryButtonColor,
              foregroundColor: Colors.white,
              label: const Text("Add"),
              onPressed: onAddTapped,
            ),
          ),
        ),
      ],
    );
  }

  void onAddTapped() {
    if (habitNameController.text.isNotEmpty) {
      HabitModel habitModel = HabitModel(
        title: habitNameController.text,
        createDate: DateTime.now(),
        streakCount: 0,
        purpose: purposeController.text,
        imageUrl: imageUrlController.text,
        completionDates: [],
        longestStreak: 0,
      );
      Provider.of<HabitProvider>(context, listen: false)
          .addHabit(
        habitModel,
      )
          .whenComplete(
        () {
          int length =
              Provider.of<HabitProvider>(context, listen: false).habits.length;

          if (length > 0) {
            length--;
          }
          context.navigator.pushReplacementNamed(
            HabitDetail.routeName,
            arguments: length,
          );
        },
      );
    }
  }
}
