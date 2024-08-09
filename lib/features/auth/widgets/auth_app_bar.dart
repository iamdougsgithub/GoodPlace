import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/utils/widgets/image_container.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      clipBehavior: Clip.none,
      // title: Stack(
      //   clipBehavior: Clip.none,
      //   alignment: Alignment.center,
      //   children: [
      //     AssetImageContainer(
      //       path: AppAssets.authTopBackgroundImage,
      //       fit: BoxFit.fill,
      //     ),
      //     Text(
      //       title,
      //     ),
      //   ],
      // ),
    );
  }
}
