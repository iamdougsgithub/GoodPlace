import 'package:flutter/material.dart';
import 'package:good_place/core/resourcers/tutorial_manager.dart';
import 'package:showcaseview/showcaseview.dart';

class TutorialWidget extends StatefulWidget {
  final Widget child;

  final TutorialKeys tutorialKey;
  final String? description;

  const TutorialWidget({
    super.key,
    required this.child,
    required this.tutorialKey,
    this.description,
  });

  @override
  State<TutorialWidget> createState() => _TutorialWidgetState();
}

class _TutorialWidgetState extends State<TutorialWidget> {
  late GlobalKey<State<StatefulWidget>> key;
  onTargetClicked() {
    TutorialManager.ins.updateTutorialStateInFirebase({
      widget.tutorialKey.name: true,
    });
  }

  @override
  void initState() {
    key = TutorialManager.keyMap[widget.tutorialKey]!;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (key.currentWidget == null) {
      return Showcase(
        disposeOnTap: true,
        onToolTipClick: () => onTargetClicked(),
        onBarrierClick: () => onTargetClicked(),
        onTargetClick: () => onTargetClicked(),
        key: key,
        description: widget.tutorialKey.tutorialDesc,
        child: widget.child,
      );
    }
    return widget.child;
  }
}

class TutorialWrapper extends StatefulWidget {
  final Widget child;
  final bool autoPlay;

  const TutorialWrapper(
      {super.key, required this.child, required this.autoPlay});

  @override
  State<TutorialWrapper> createState() => _TutorialWrapperState();
}

class _TutorialWrapperState extends State<TutorialWrapper> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      disableBarrierInteraction: true,
      autoPlayDelay: const Duration(milliseconds: 3500),
      // enableAutoScroll: true,
      autoPlay: widget.autoPlay,
      onComplete: (p0, p1) {
        TutorialManager.ins.onAutoPlayComplete(p1);
      },
      builder: (context) => widget.child,
    );
  }
}
