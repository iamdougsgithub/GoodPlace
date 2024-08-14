import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/extensions/context_extension.dart';

import '../../../config/theme.dart';
import '../../../core/constants/app_assets.dart';

class IDrawer extends StatefulWidget {
  const IDrawer({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<IDrawer> createState() => _IDrawerState();
}

class _IDrawerState extends State<IDrawer> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: selectedIndex,
      onDestinationSelected: (value) {
        setState(() {
          selectedIndex = value;
        });
      },
      indicatorColor: AppColors.primaryButtonColor,
      children: [
        userTile(context),
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
        onPressed: () => FirebaseAuth.instance.signOut(),
        icon: AppAssets.logOutIcon,
      ),
    );
  }
}
