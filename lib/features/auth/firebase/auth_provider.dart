import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_place/features/auth/firebase/authService.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  AuthProvider() {
    _authService.authStateChanges.listen(_authStateChanged);
  }

  User? get user => _user;

  void _authStateChanged(User? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
