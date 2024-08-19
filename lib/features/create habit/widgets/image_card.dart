import 'dart:async';
import 'package:flutter/material.dart';
import 'package:good_place/core/extensions/context_extension.dart';

import '../../../core/constants/app_assets.dart';
import 'add_image_bottom_sheet.dart';

class ImageCard extends StatefulWidget {
  final TextEditingController urlController;
  const ImageCard({super.key, required this.urlController});

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  String? _url;
  onImageCardTapped() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const AddImageBottomSheet();
      },
    ).then(_setImageUrl);
  }

  FutureOr<Null> _setImageUrl(url) {
    if (url.runtimeType == String) {
      url as String;
      setState(() {
        widget.urlController.text = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.3),
      width: double.infinity,
      child: InkWell(
        onTap: () => onImageCardTapped(),
        child: Card(
          child: widget.urlController.text.isNotEmpty
              ? Image.network(
                  widget.urlController.text,
                  fit: BoxFit.cover,
                )
              : AppAssets.addImageIcon,
        ),
      ),
    );
  }
}
