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
      disposeOnTap: true,
      onToolTipClick: () => onTargetClicked(),
      onBarrierClick: () => onTargetClicked(),
      onTargetClick: () => onTargetClicked(),
      key: TutorialManager.keyMap[tutorialKey]!,
      description: tutorialKey.tutorialDesc,
      child: child,
    );
  }
}

class TutorialWrapper extends StatelessWidget {
  final Widget child;

  const TutorialWrapper({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      disableBarrierInteraction: true,
      autoPlayDelay: const Duration(seconds: 4),
      enableAutoScroll: true,
      autoPlay: TutorialManager.ins.tutorialState.isEmpty,
      onComplete: (p0, p1) {
        TutorialManager.ins.onAutoPlayComplete(p1);
      },
      builder: (context) => child,
    );
  }
}
