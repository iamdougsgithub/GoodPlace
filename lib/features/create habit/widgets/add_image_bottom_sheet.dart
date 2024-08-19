import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:good_place/core/constants/app_border_radius.dart';
import 'package:good_place/core/constants/app_paddings.dart';
import 'package:good_place/core/extensions/context_extension.dart';
import 'package:good_place/logger.dart';

import '../services/image_api_service.dart';

class AddImageBottomSheet extends StatefulWidget {
  const AddImageBottomSheet({
    super.key,
  });

  @override
  State<AddImageBottomSheet> createState() => _AddImageBottomSheetState();
}

class _AddImageBottomSheetState extends State<AddImageBottomSheet>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  Map<String, dynamic>? data;
  final String unsplashText = "Search Images via Unsplash";
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: 0.1,
    );
    _animationController.forward();
    _animationController.addListener(_listener);
    super.initState();
  }

  _listener() {
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.removeListener(() {});
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        result = _urlController.text;
        setState(() {});
      },
      child: BottomSheet(
        animationController: _animationController,
        enableDrag: true,
        showDragHandle: true,
        onClosing: () {
          // logger.e(_urlController.text);
          context.navigator.pop(_urlController.text);
        },
        constraints: BoxConstraints(
          maxHeight: context.dynamicHeight(0.7) * _animationController.value,
          minWidth: context.dynamicWidth(1),
        ),
        builder: (context) {
          return Card(
            child: Column(
              children: [
                SearchBar(
                  controller: _searchController,
                  onSubmitted: onSubmit,
                ),
                const Gap(AppPaddings.smallPaddingValue),
                data != null
                    ? _SearchResults(
                        data: data,
                        urlController: _urlController,
                      )
                    : Text(
                        unsplashText,
                        style: context.textTheme.labelLarge,
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  void onSubmit(String value) async {
    if (value.isNotEmpty) {
      data = await ImageApiService().fetchPictures(value);
      setState(() {});
    }
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({
    required this.data,
    required this.urlController,
  });
  final TextEditingController urlController;

  final Map<String, dynamic>? data;

  void onImageTapped(BuildContext ctx, String url) {
    urlController.text = url;
    ctx.navigator.pop(url);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 16 / 12,
          crossAxisCount: 2,
          crossAxisSpacing: AppPaddings.xxsmallPaddingValue,
          mainAxisSpacing: AppPaddings.xxsmallPaddingValue,
        ),
        itemBuilder: (context, index) {
          final url = data?["results"][index]["urls"]["raw"];
          return InkWell(
            onTap: () => onImageTapped(context, url),
            child: ClipRRect(
              borderRadius: AppBorderRadius.mediumBorderRadius,
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
