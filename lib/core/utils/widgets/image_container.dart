// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AssetImageContainer extends StatelessWidget {
  const AssetImageContainer({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  });
  final String path;
  final double? height;
  final double? width;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
