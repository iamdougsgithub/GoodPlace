import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_place/core/resourcers/error_texts.dart';
import 'package:good_place/core/utils/models/habit_model.dart';
import 'package:good_place/core/utils/widgets/custom_toast.dart';
import 'package:good_place/features/user_data/user_service.dart';
import 'package:good_place/logger.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'google_sign_in.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  static User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Register
  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firebaseAuth.currentUser?.updateDisplayName(name);

      //  UserDatabaseService().addUser();

      return true; //başarılı kayıt
    } on FirebaseAuthException catch (e) {
      Toast.errToast(title: AppErrorText.errorMessageConverter(e.code));
      return false;
    } catch (e) {
      Toast.errToast(title: AppErrorText.errorMessageConverter(e.toString()));
      return false;
    }
  }

  // Login
  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

/*
// =>>>>>>>>>>>>> USER UPDATE
// TODO: Onboarding kontrol işlemi olan yere bunu koy.
      UserDatabaseService()
          .updateUserField(currentUser!.uid, "onboardingCompleted", true);

// =>>>>>>>>>>>>>>>>  USER GET Field

       Map<String, dynamic> userDetails =
          await UserDatabaseService().getUserDetails();

      print(userDetails);

// =>>>>>>>>>>>>>>>>>>>>>  HABİT ADD

      DateTime now = DateTime.now(); // Mevcut tarihi al

      UserDatabaseService().addHabit(HabitModel(
          title: "Sebze ye",
          createDate: now,
          streakCount: 3,
          completionDates: []));

//=>>>>>>>>>>>>>>>>> Delete habit
      UserDatabaseService().deleteHabit("txGejC5w2BzjCY8qKh0Y");*/

      return true; //başarılı
    } on FirebaseAuthException catch (e) {
      Toast.errToast(title: AppErrorText.errorMessageConverter(e.code));
      return false;
    } catch (e) {
      print('Sign In Error: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    if (_googleSignIn.currentUser != null) {
      try {
        await _googleSignIn.signOut();
        await _googleSignIn.disconnect();
      } catch (e) {
        print('Sign Out Error: $e');
      }
    } else {
      try {
        await _firebaseAuth.signOut();
      } catch (e) {
        print('Sign Out Error: $e');
      }
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
