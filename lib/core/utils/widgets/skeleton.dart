import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonWidget extends StatelessWidget {
  const SkeletonWidget(this.child, {super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: child,
    );
  }
}
