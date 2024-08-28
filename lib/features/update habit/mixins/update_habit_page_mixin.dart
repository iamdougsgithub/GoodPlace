import 'package:flutter/material.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/core/utils/widgets/custom_toast.dart';
import 'package:good_place/features/update%20habit/pages/update_habit_page.dart';
import 'package:provider/provider.dart';

import '../../../config/theme.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/utils/models/habit_model.dart';
import '../../user_data/habit_provider.dart';

mixin UpdateHabitMixin on State<UpdateHabitPage> {
  final TextEditingController habitNameController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  late String appBarTitle;
  final String habitNameTextFieldLabel = "Habit Name";
  final String habitPurposeTextFieldLabel = "My purpose";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String response = "";

  late HabitProvider habitProvider;
  late HabitModel _habitModel;

  void a() {
    habitProvider = Provider.of<HabitProvider>(context);
  }

  @override
  void initState() {
    _habitModel = widget.habitModel;
    appBarTitle = "Updating ${_habitModel.title}";
    habitNameController.text = _habitModel.title;
    purposeController.text = _habitModel.purpose ?? "";
    imageUrlController.text = _habitModel.imageUrl ?? "";
    super.initState();
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
              label: const Text("Update"),
              onPressed: onUpdateTapped,
            ),
          ),
        ),
      ],
    );
  }

  void onUpdateTapped() {
    if (mounted) {
      if (formKey.currentState!.validate()) {
        HabitModel habitModel = HabitModel(
          id: _habitModel.id,
          title: habitNameController.text,
          createDate: DateTime.now(),
          streakCount: 0,
          purpose: purposeController.text,
          imageUrl: imageUrlController.text,
          completionDates: [],
          longestStreak: 0,
        );
        Provider.of<HabitProvider>(context, listen: false)
            .updateHabit(
          habitModel.id ?? "",
        )
            .whenComplete(() {
          Toast.succToast(title: "${habitModel.title} Successfully updated.");
          context.pop();
        });
      }
    }
  }

  @override
  void dispose() {
    habitNameController.dispose();
    imageUrlController.dispose();
    purposeController.dispose();
    super.dispose();
  }
}
