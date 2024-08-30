import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:good_place/core/constants/app_assets.dart';
import 'package:good_place/core/resourcers/tutorial_manager.dart';
import 'package:good_place/core/utils/models/habit_model.dart';
import 'package:good_place/core/utils/widgets/tutorial_widget.dart';
import 'package:good_place/features/My%20Habits/pages/my_habits_page.dart';
import 'package:good_place/features/habit%20detail/pages/habit_detail.dart';
import 'package:good_place/features/home/pages/home_page.dart';
import 'package:good_place/features/user_data/habit_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/widgets/card_background_cover.dart';
import '../../../core/constants/app_border_radius.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/widgets/custom_toast.dart';

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
              child: habitProvider.habits.isEmpty
                  ? _noHabitsCard(context)
                  : _habitList(habitProvider),
            );
          },
        ),
      ],
    );
  }

  Widget _noHabitsCard(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Flexible(child: AppAssets.noHabitsFound),
          Markdown(
              shrinkWrap: true,
              data: "You don't have any habits.**Add Now**.",
              styleSheet: MarkdownStyleSheet(
                textAlign: WrapAlignment.center,
                p: context.textTheme.bodyLarge
                    ?.copyWith(foreground: Paint()..color = Colors.white),
              )),
        ],
      ),
    );
  }

  Widget _habitList(
    HabitProvider habitProvider,
  ) {
    return TutorialWidget(
      tutorialKey: TutorialKeys.habitCard,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: habitProvider.habits.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _HabitCard(
              index: index,
            );
          }).animate().shimmer(),
    );
  }

  Widget titleRow(BuildContext context) {
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
        TutorialWidget(
          tutorialKey: TutorialKeys.seeAll,
          child: TextButton(
            onPressed: () {
              context.navigator.pushNamed(MyHabitsPage.routeName);
            },
            style: TextButton.styleFrom(),
            child: Text(
              "See All",
              style: context.textTheme.labelLarge?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn();
  }
}

class _HabitCard extends StatefulWidget {
  // final HabitModel habitModel;
  final int index;
  const _HabitCard({required this.index});

  @override
  State<_HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<_HabitCard> {
  late bool _isDone;
  late String _title;
  late String? _imageUrl;

  @override
  void initState() {
    super.initState();
  }

  bool get _imageExist => _imageUrl != null && _imageUrl!.isEmpty == false;

  @override
  Widget build(BuildContext context) {
    HabitProvider habitProvider = Provider.of<HabitProvider>(context);

    final HabitModel habitModel = habitProvider.habits[widget.index];

    _isDone = habitModel.done;
    _title = habitModel.title;
    _imageUrl = habitModel.imageUrl;
    return GestureDetector(
      onTap: () => context.navigator.pushNamed(
        HabitDetail.routeName,
        arguments: widget.index,
      ),
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: Container(
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.symmetric(
            horizontal: AppPaddings.xxsmallPaddingValue,
          ),
          decoration: _boxDecoration(),
          child: CardBackgroundImageFilter(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPaddings.xxsmallPaddingValue,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: LayoutBuilder(
                    builder: (context, constraints) => SizedBox(
                      height: constraints.maxHeight * .4,
                      width: constraints.maxWidth,
                      child: CheckboxListTile(
                        value: _isDone,
                        contentPadding: EdgeInsets.zero,

                        /// Title
                        title: Text(
                          _title,
                          style: context.textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),

                        onChanged: (_) {
                          if (!_isDone) {
                            habitProvider.updateHabit(habitModel.id ?? "");
                            Toast.wellDone();
                            setState(() {
                              _isDone = !_isDone;
                            });
                          } else {
                            Toast.succToast(
                                title: "You already done it for today.",
                                desc: "You should wait for tomorrow.");
                          }
                        },
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: AppBorderRadius.smallBorderRadius,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: _imageExist
            ? NetworkImage(
                _imageUrl ?? "",
              )
            : AssetImage(AppAssets.authTopBackgroundImage),
      ),
    );
  }
}
