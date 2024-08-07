// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'core/constants/app_assets.dart';
import 'core/extensions/context_extension.dart';
import 'core/utils/widgets/custom_buttons.dart';
import 'core/utils/widgets/image_container.dart';

/// Burası sadece bazı widgetları sergilemek ve test etmek için var.
/// Son aşamada burası silinecek.
class Playground extends StatelessWidget {
  const Playground({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AssetImageContainer(
            path: AppAssets.welcomePageImage,
            width: context.dynamicWidth(1),
            height: context.dynamicHeight(0.65),
            fit: BoxFit.fill,
          ),
          Gap(10),
          Row(
            children: [
              ExpandedOutlinedButton(
                onPressed: () {},
                label: "Label",
              ),
            ],
          ),
          Gap(10),
          Row(
            children: [
              ExpandedFilledButton(
                onPressed: () {},
                label: "Label",
              ),
            ],
          ),
          Gap(10),
          Row(
            children: [
              ExpandedOutlinedButtonWithIcon(
                onPressed: () {},
                label: "Label",
                icon: Icon(Icons.g_mobiledata_sharp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
