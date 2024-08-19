import 'package:flutter/material.dart';
import 'package:good_place/features/auth/firebase/authService.dart';
import 'package:good_place/features/auth/pages/welcome_page.dart';
import 'package:good_place/features/home/pages/home_page.dart';
import 'package:good_place/features/onboarding/onboarding_page.dart';
import 'package:good_place/features/user_data/user_database_service.dart';
import 'package:good_place/logger.dart';

/// Kullanıcı giriş yapmışsa AnaSayfaya , yapmamışsa [WelcomePage]'e gönder.
class AuthManager extends StatelessWidget {
  static const routeName = "authmanager";

  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            logger.i("Home-Onboarding");
            return FutureBuilder(
              future: UserDatabaseService().getUserDetails(),
              builder: (context, futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (futureSnapshot.hasError) {
                  return Center(child: Text('Error: ${futureSnapshot.error}'));
                } else if (futureSnapshot.hasData) {
                  bool isOnboardingCompleted = futureSnapshot.data!;
                  return isOnboardingCompleted
                      ? const HomePage()
                      : const OnboardingPage();
                } else {
                  return const Center(child: Text('No user details available'));
                }
              },
            );
          } else {
            logger.i("Welcome");
            return const WelcomePage();
          }
        });
  }
}
