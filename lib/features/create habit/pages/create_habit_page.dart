import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/utils/widgets/tutorial_widget.dart';

import '../../../config/theme.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../mixins/create_habit_mixin.dart';
import '../widgets/create_habit_form.dart';
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

  @override
  Widget build(BuildContext context) {
    return TutorialWrapper(
      child: Scaffold(
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
      ),
    );
  }
}
