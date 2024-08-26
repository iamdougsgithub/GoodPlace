import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_place/core/resourcers/firebase_utils.dart';
import 'package:good_place/logger.dart';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  Future signIn() async {
    try {
      final GoogleSignInAccount? _gSign =
          await FirebaseUtils.googleSignIn.signIn();
      if (_gSign != null) {
        final GoogleSignInAuthentication _gAuth = await _gSign.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: _gAuth.idToken,
          accessToken: _gAuth.accessToken,
        );
        return credential;
      }
      return "Google sign in failed";
    } catch (e) {
      logger.e(e);
      return e.toString();
    }
  }
}
