import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/utils/widgets/custom_buttons.dart';
import '../../../core/utils/widgets/image_container.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExpandedOutlinedButtonWithIcon(
          icon: AssetImageContainer(path: AppAssets.googleIcon),
          label: "CONTINUE WITH GOOGLE",
          onPressed: () {},
        ),
      ],
    );
  }
}
