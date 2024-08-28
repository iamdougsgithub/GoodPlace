import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/utils/widgets/custom_text_form_field.dart';
import '../../chatgpt/ChatGptService.dart';
import '../../chatgpt/SystemContentTexts.dart';

class UpdateHabitForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String habitNameTextFieldLabel;
  final TextEditingController habitNameController;
  final TextEditingController imageUrlController;
  final String habitPurposeTextFieldLabel;
  final TextEditingController purposeController;
  const UpdateHabitForm(
      {super.key,
      required this.habitNameTextFieldLabel,
      required this.habitNameController,
      required this.habitPurposeTextFieldLabel,
      required this.purposeController,
      required this.formKey,
      required this.imageUrlController});

  @override
  State<UpdateHabitForm> createState() => _UpdateHabitFormState();
}

class _UpdateHabitFormState extends State<UpdateHabitForm> {
  Future<void> generateResponse(
    String? userContentText,
    String? userContentImageUrl,
    String systemContentText,
    TextEditingController controller,
  ) async {
    controller.clear();
    final body = ChatgptService().getApiBody(
        systemContentText: systemContentText,
        userContentText: userContentText,
        imageUrl: userContentImageUrl);

    var response = '';
    ChatgptService().getChatResponse(body).listen((word) {
      setState(() {
        response += word;
        controller.text = response;
      });
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          /// Habit Name
          NormalTextFormField(
            label: widget.habitNameTextFieldLabel,
            controller: widget.habitNameController,
            textCapitalization: TextCapitalization.words,
            maxLength: 25,
            validator: (value) =>
                value?.trim() == "" ? "This field can't be empty ! " : null,
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
            // validator: (value) => widget.habitNameController.text.trim() == "" ?"" :,
            label: widget.habitPurposeTextFieldLabel,
            suffixIcon: SizedBox(
              width: 32,
              height: 32,
              child: GestureDetector(
                onTap: onAIButtonTapped,
                child: Lottie.asset(AppAssets.aiButtonAnimation),
              ),
            ),
            constraints: BoxConstraints(
              maxHeight: context.dynamicHeight(0.18),
            ),
            controller: widget.purposeController,
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
    );
  }

  void onAIButtonTapped() {
    if ((widget.habitNameController.text.isNotEmpty) ||
        (widget.imageUrlController.text.isNotEmpty)) {
      generateResponse(
        widget.habitNameController.text,
        widget.imageUrlController.text,
        purposeSystemContentText,
        widget.purposeController,
      );
    } else {
      widget.purposeController.text =
          "Please provide a valid habit name first.";
    }
  }
}
