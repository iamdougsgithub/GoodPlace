import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/features/create%20habit/widgets/create_habit_form.dart';

import 'package:provider/provider.dart';

import '../../../config/theme.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/models/habit_model.dart';
import '../../habit detail/pages/habit_detail.dart';
import '../../user_data/habit_provider.dart';
import '../mixins/create_habit_mixin.dart';
import '../widgets/image_card.dart';

class CreateHabitPage extends StatefulWidget {
  static const String routeName = "create-habit";
  const CreateHabitPage({super.key});

  @override
  State<CreateHabitPage> createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage>
    with CreateHabitMixin {
  String response = "";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeScaffoldColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          context.mediaQuery.viewInsets.bottom > 1 ? null : fab(),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppPaddings.homeScreenHorizontalPadding,
            child: Column(
              children: [
                /// Image Card
                ImageCard(
                  urlController: imageUrlController,
                ),
                const Gap(AppPaddings.smallPaddingValue),
                CreateHabitForm(
                  habitNameTextFieldLabel: habitNameTextFieldLabel,
                  habitNameController: habitNameController,
                  habitPurposeTextFieldLabel: habitPurposeTextFieldLabel,
                  purposeController: purposeController,
                  formKey: formKey,
                  imageUrlController: imageUrlController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
    if (mounted) {
      if (formKey.currentState!.validate()) {
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
            int length = Provider.of<HabitProvider>(context, listen: false)
                .habits
                .length;

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
}
