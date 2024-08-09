import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/widgets/image_container.dart';

class AuthTitleWidget extends StatelessWidget {
  const AuthTitleWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AssetImageContainer(
          path: AppAssets.authTopBackgroundImage,
          fit: BoxFit.fill,
          height: context.dynamicHeight(0.3),
          width: context.dynamicWidth(1),
        ),
        Text(
          title,
          style: context.textTheme.titleLarge,
        ),
      ],
    );
  }
}
