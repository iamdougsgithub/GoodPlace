import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return const HomePage(); // TODO: Home page hazırlandığında buraya o eklenecek
        } else {
          return const WelcomePage();
        }
      },
    );
  }
}
