import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:good_place/core/constants/app_assets.dart';
import 'package:good_place/core/utils/models/habit_model.dart';
import 'package:good_place/features/user_data/habit_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/widgets/card_background_cover.dart';
import '../../../core/constants/app_border_radius.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import 'package:good_place/logger.dart';

class MyHabitsSection extends StatelessWidget {
  const MyHabitsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Title Row
        titleRow(context),
        Consumer<HabitProvider>(
          builder: (context, habitProvider, child) {
            return SizedBox(
              height: context.dynamicHeight(0.15),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: habitProvider.habits.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return _HabitCard(
                      habitModel: habitProvider.habits[index],
                    );
                  }),
            );
          },
        ),
      ],
    );
  }

  Row titleRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Title
        Text(
          "My Habits",
          style: context.textTheme.titleMedium?.copyWith(
            color: Colors.white,
          ),
        ),

        /// See All button
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(),
          child: Text(
            "See All",
            style: context.textTheme.labelLarge?.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _HabitCard extends StatefulWidget {
  final HabitModel habitModel;
  const _HabitCard({required this.habitModel});

  @override
  State<_HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<_HabitCard> {
  late bool _isDone;
  late String _title;
  late String? _imageUrl;

  @override
  void initState() {
    final HabitModel _habitModel = widget.habitModel;
    _isDone = _habitModel.done;
    _title = _habitModel.title;
    _imageUrl = _habitModel.imageUrl;
    super.initState();
  }

  bool get _imageExist => _imageUrl != null && _imageUrl!.isEmpty == false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(
          horizontal: AppPaddings.xxsmallPaddingValue,
        ),
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.smallBorderRadius,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: _imageExist
                ? NetworkImage(
                    _imageUrl ?? "",
                  )
                : AssetImage(AppAssets.authTopBackgroundImage),
          ),
        ),
        child: CardBackgroundImageFilter(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPaddings.xxsmallPaddingValue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 12,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        _title,
                        style: context.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      value: _isDone,
                      onChanged: (_) {
                        _isDone = !_isDone;

                        /// TODO: Burayı sonra yap.
                        // HabitProvider.instance.updateHabit(
                        //   widget.habitModel.id ?? "",
                        //   {
                        //     "completionDates": FieldValue.arrayUnion([
                        //       DateTime.now(),
                        //     ]),
                        //   },
                        // );
                        setState(() {});
                      },
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
