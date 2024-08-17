import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:good_place/features/My%20Habits/pages/my_habits_page.dart';
import 'package:good_place/features/auth/firebase/authService.dart';
import 'package:good_place/features/home/pages/home_page.dart';
import '../../../core/extensions/context_extension.dart';

import '../../../config/theme.dart';
import '../../../core/constants/app_assets.dart';

class IDrawer extends StatefulWidget {
  const IDrawer({
    super.key,
    required this.context,
    required this.selectedIndex,
  });
  final int selectedIndex;
  final BuildContext context;

  @override
  State<IDrawer> createState() => _IDrawerState();
}

class _IDrawerState extends State<IDrawer> {
  late int selectedIndex;
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      indicatorColor: AppColors.primaryButtonColor,
      children: [
        userTile(context),
        const Divider(),
        NavigationDrawerDestination(
          icon: AppAssets.homeIcon,
          label: const Text(
            "Home",
          ),
        ),

        /// Navigate to My Habits
        const NavigationDrawerDestination(
          icon: SizedBox(),
          label: Text("My Habits"),
        ),
      ],
    );
  }

  void onDestinationSelected(value) {
    // setState(() {
    //   // selectedIndex = value;
    // });
    switch (value) {
      case 0:
        context.navigator.pushReplacementNamed(HomePage.routeName);
        break;
      case 1:
        context.navigator.pushReplacementNamed(MyHabitsPage.routeName);
        break;
      default:
    }
  }

  ListTile userTile(BuildContext context) {
    return ListTile(
      /// TODO : Get this from firebase
      /// User name
      title: Text(
        "memrec",
        style: context.textTheme.labelLarge,
      ),

      /// TODO : Get this from firebase
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),

      /// Log out button
      trailing: IconButton(
        onPressed: () async => await AuthService().signOut().then(
              (_) => context.navigator.pushReplacementNamed("/"),
            ),
        icon: AppAssets.logOutIcon,
      ),
    );
  }
}
