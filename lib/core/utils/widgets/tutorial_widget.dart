import 'package:flutter/material.dart';
import 'package:good_place/core/resourcers/tutorial_manager.dart';
import 'package:showcaseview/showcaseview.dart';

class TutorialWidget extends StatelessWidget {
  final Widget child;

  final TutorialKeys tutorialKey;
  final String? description;

  const TutorialWidget({
    super.key,
    required this.child,
    required this.tutorialKey,
    this.description,
  });

  onTargetClicked() {
    TutorialManager.ins.updateTutorialStateInFirebase({
      tutorialKey.name: true,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Showcase(
      disableBarrierInteraction: true,
      disposeOnTap: true,
      // onBarrierClick: () => logger.i("barrier"),
      onTargetClick: () => onTargetClicked(),
      key: TutorialManager.keyMap[tutorialKey]!,
      description: tutorialKey.tutorialDesc,
      child: child,
    );
  }
}
