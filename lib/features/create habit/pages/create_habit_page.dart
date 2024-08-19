import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/config/theme.dart';
import 'package:good_place/core/constants/app_paddings.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/core/utils/models/habit_model.dart';
import 'package:good_place/core/utils/widgets/custom_text_form_field.dart';
import 'package:good_place/features/habit%20detail/pages/habit_detail.dart';
import 'package:good_place/features/user_data/habit_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/image_card.dart';

class CreateHabitPage extends StatefulWidget {
  static const String routeName = "create-habit";
  const CreateHabitPage({super.key});

  @override
  State<CreateHabitPage> createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  final TextEditingController habitNameController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  @override
  void dispose() {
    habitNameController.dispose();
    imageUrlController.dispose();
    purposeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.homeScaffoldColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: fab(),
      appBar: AppBar(
        title: const Text("Create Your Habit"),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPaddings.homeScreenHorizontalPadding,
          child: Column(
            children: [
              /// Image Card
              ImageCard(
                urlController: imageUrlController,
              ),
              const Gap(AppPaddings.smallPaddingValue),

              /// Habit Name
              NormalTextFormField(
                label: "Habit Name",
                controller: habitNameController,
                textCapitalization: TextCapitalization.words,
                maxLength: 25,
                buildCounter: (context,
                    {required currentLength,
                    required isFocused,
                    required maxLength}) {
                  return Text(
                    "$currentLength / $maxLength",
                    style: context.textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                    ),
                  );
                },
              ),
              const Gap(AppPaddings.smallPaddingValue),

              /// Purpose text Field
              NormalTextFormField(
                label: "My purpose",
                controller: purposeController,
                textInputAction: TextInputAction.done,
                maxLength: 25,
                textCapitalization: TextCapitalization.sentences,
                buildCounter: (context,
                    {required currentLength,
                    required isFocused,
                    required maxLength}) {
                  return Text(
                    "$currentLength / $maxLength",
                    style: context.textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ],
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
      HabitProvider.instance
          .addHabit(
            habitModel,
          )
          .whenComplete(
            () => context.navigator.pushReplacementNamed(HabitDetail.routeName,
                arguments: Provider.of<HabitProvider>(context, listen: false)
                        .habits
                        .length -
                    1),
          );
    }
  }
}
