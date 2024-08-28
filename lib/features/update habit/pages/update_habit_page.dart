import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/utils/models/habit_model.dart';
import 'package:good_place/features/update%20habit/mixins/update_habit_page_mixin.dart';
import 'package:good_place/features/user_data/habit_provider.dart';
import 'package:provider/provider.dart';

import '../../../config/theme.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../../create habit/widgets/image_card.dart';
import '../widgets/create_habit_form.dart';

class UpdateHabitPage extends StatefulWidget {
  final HabitModel habitModel;
  static const String routeName = "create-habit";
  const UpdateHabitPage({super.key, required this.habitModel});

  @override
  State<UpdateHabitPage> createState() => _UpdateHabitPageState();
}

class _UpdateHabitPageState extends State<UpdateHabitPage>
    with UpdateHabitMixin {
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
                UpdateHabitForm(
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
}
