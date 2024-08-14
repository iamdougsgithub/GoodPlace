import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:good_place/features/My%20Habits/pages/my_habits_page.dart';
import 'package:good_place/features/auth/pages/welcome_page.dart';
import 'package:good_place/features/home/pages/home_page.dart';

/// Kullanıcı giriş yapmışsa AnaSayfaya , yapmamışsa [WelcomePage]'e gönder.
class AuthManager extends StatelessWidget {
  static const routeName = "authmanager";
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // logger.i(snapshot.hasData);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          // TODO: Home page ile değiştir.
          return const MyHabitsPage();
        } else {
          return const WelcomePage();
        }
      },
    );
  }
}
