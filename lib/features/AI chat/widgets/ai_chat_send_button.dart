import 'dart:math';

import 'package:flutter/material.dart';
import 'package:good_place/logger.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_assets.dart';

class AIChatSendButton extends StatefulWidget {
  final Function? onTap;
  const AIChatSendButton({
    super.key,
    required this.onTap,
  });

  @override
  State<AIChatSendButton> createState() => _AIChatSendButtonState();
}

class _AIChatSendButtonState extends State<AIChatSendButton>
    with SingleTickerProviderStateMixin {
  bool animate = false;
  late Animation<double> animation;
  late AnimationController controller;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    // controller.addListener(listener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          logger.i("message");
          widget.onTap!();
          controller.forward().then(
                (value) => controller.reset(),
              );
        }
      },
      child: CircleAvatar(
        radius: 24,
        child: Lottie.asset(
          AppAssets.aiChatSendButton,
          fit: BoxFit.fill,
          controller: controller,
        ),
      ),
    );
  }
}
