import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  // Register
  Future<User?> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print('Register Error: $e');
      return null;
    }
  }

  /*Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
*/
  // Login
  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print('Sign In Error: $e');
      return null;
    }
  }

/*
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
*/
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
