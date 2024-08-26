import 'package:flutter/material.dart';
import 'package:good_place/features/My%20Habits/pages/my_habits_page.dart';
import 'package:good_place/features/auth/firebase/authService.dart';
import 'package:good_place/features/home/pages/home_page.dart';
import 'package:good_place/features/home/widgets/welcome_text.dart';
import '../../../core/extensions/context_extension.dart';

import '../../../config/theme.dart';
import '../../../core/constants/app_assets.dart';
import '../../user_data/user_database_service.dart';

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

        /// Home
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

        /// Danger Zone
        ExpansionTile(
          textColor: AppColors.errDark,
          iconColor: AppColors.errDark,
          collapsedIconColor: AppColors.errDark,
          expandedAlignment: Alignment.centerLeft,
          leading: Icon(
            Icons.dangerous_outlined,
            color: AppColors.errDark,
          ),
          title: Text(
            "Danger Zone",
            style: context.textTheme.labelLarge
                ?.copyWith(color: AppColors.errDark),
          ),
          children: [
            /// Delete Account
            ListTile(
              leading: const Icon(
                Icons.delete_forever_outlined,
              ),
              title: Text(
                "Delete My Account",
                style: context.textTheme.labelMedium
                    ?.copyWith(color: AppColors.errDark),
              ),
              splashColor: AppColors.errLight,
              iconColor: AppColors.errDark,
              onTap: () => showAdaptiveDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => const _AreYouSureDialog(),
              ),
            )
          ],
        )
      ],
    );
  }

  void onDestinationSelected(value) {
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
        WelcomeText().userName,
        style: context.textTheme.labelLarge,
      ),

      /// TODO : Get this from firebase
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),

      /// Log out button
      trailing: IconButton(
        onPressed: () async => await AuthService()
            .signOut()
            .then((_) => context.navigator.pushReplacementNamed("/")

                //Navigator.of(context).popUntil((route) => route.isFirst),
                ),
        icon: AppAssets.logOutIcon,
      ),
    );
  }
}

class _AreYouSureDialog extends StatelessWidget {
  const _AreYouSureDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.errLight,
      titleTextStyle: context.textTheme.headlineSmall?.copyWith(
        color: Colors.white,
      ),
      contentTextStyle: context.textTheme.bodyLarge?.copyWith(
        foreground: Paint()..color = Colors.white,
      ),
      title: const Text("Are You Sure ? "),
      content: const Text(
        "After you clicked confirm your account will be deleted permanently and you will not be able to recover.",
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: <Widget>[
        /// Delete Button
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.errDark,
          ),
          onPressed: () async => await onIamSureTapped(context),
          child: const Text("I do want to delete"),
        ),

        /// Cancel Button
        ElevatedButton(
          onPressed: () => context.pop(),
          child: const Text("I don't want to delete"),
        ),
      ],
    );
  }

  onIamSureTapped(BuildContext context) async {
    await UserDatabaseService().deleteUser().whenComplete(
          () => context.pushReplacementNamed("/"),
        );
  }
}
