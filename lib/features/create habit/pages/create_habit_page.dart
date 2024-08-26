import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import 'package:good_place/logger.dart';

import '../../../config/theme.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/widgets/custom_text_form_field.dart';
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

                /// Habit Name
                NormalTextFormField(
                  label: habitNameTextFieldLabel,
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
                TextAreaFormField(
                  label: habitPurposeTextFieldLabel,
                  suffixIcon: SizedBox(
                    width: 32,
                    height: 32,
                    child: GestureDetector(
                      onTap: () => logger.i("asdasds"),
                      child: Lottie.asset(AppAssets.aiButtonAnimation),
                    ),
                  ),
                  constraints: BoxConstraints(
                    maxHeight: context.dynamicHeight(0.18),
                  ),
                  controller: purposeController,
                  textInputAction: TextInputAction.done,
                  maxLength: 500,
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
      ),
    );
  }
}
