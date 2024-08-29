import 'package:flutter/material.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/core/resourcers/tutorial_manager.dart';
import 'package:good_place/core/utils/widgets/tutorial_widget.dart';
import 'package:good_place/features/create%20habit/pages/create_habit_page.dart';

import '../../../config/theme.dart';
import '../../constants/app_assets.dart';

class AddHabitButton extends StatelessWidget {
  const AddHabitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TutorialWidget(
      description: TutorialKeys.createHabit.tutorialDesc,
      tutorialKey: TutorialKeys.createHabit,
      child: FloatingActionButton(
        onPressed: () => context.navigator.pushNamed(CreateHabitPage.routeName),
        backgroundColor: AppColors.primaryButtonColor,
        foregroundColor: AppColors.secondaryButtonColor,
        child: AppAssets.fabAddIcon,
      ),
    );
  }
}
