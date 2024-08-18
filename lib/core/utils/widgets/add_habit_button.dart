import 'package:flutter/material.dart';

import '../../../config/theme.dart';
import '../../constants/app_assets.dart';

class AddHabitButton extends StatelessWidget {
  const AddHabitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: AppColors.primaryButtonColor,
      foregroundColor: AppColors.secondaryButtonColor,
      child: AppAssets.fabAddIcon,
    );
  }
}
