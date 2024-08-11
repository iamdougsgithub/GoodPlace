import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:good_place/core/resourcers/error_texts.dart';
import 'package:good_place/core/utils/widgets/custom_toast.dart';
import 'package:good_place/logger.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firebaseAuth.currentUser?.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      Toast.errToast(title: AppErrorText.errorMessageConverter(e.code));
    } catch (e) {
      Toast.errToast(title: AppErrorText.errorMessageConverter(e.toString()));
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    if (_googleSignIn.currentUser != null) {
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();
    } else {
      await _firebaseAuth.signOut();
    }
  }

  Future<void> deleteUser() async {
    await _firebaseAuth.currentUser!.delete();
  }

  Future<void> signInWithGoogle() async {
    try {
      final credential = await GoogleSignInService().signIn();

      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      Toast.errToast(title: AppErrorText.errorMessageConverter(e.code));
    } catch (e) {
      logger.e(e);
      Toast.errToast(title: e.toString());
    }
  }

// ileride anonim kullanıcı girişi eklemek istersek kullanabiliriz.
/* 
  Future<User?> signInAnonymously() async {
    final UserCredential userCredential =
        await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }
*/

/*
  Future<void> sendPasswordResetEmail({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> confirmPasswordReset({
    required String code,
    required String newPassword,
  }) async {
    await _firebaseAuth.confirmPasswordReset(
        code: code, newPassword: newPassword);
  }
*/
}
