import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseUtils {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  User? get currentUser => firebaseAuth.currentUser;
  // Auth state changes stream
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  // /// UID of current user
  String? get uid => firebaseAuth.currentUser?.uid;
}

///
///Bu class'ın kullanım amacı Firebase'de genel olarak kullandığımız instance'lara
///daha kolay bir şekilde ulaşmak
///
/// ### İçerik
/// `firestore = FirebaseFirestore.instance`
///
/// `firebaseAuth = FirebaseAuth.instance`
///
/// `User? get currentUser => firebaseAuth.currentUser`
///
///`storage = FirebaseStorage.instance`
///### Kullanım Şekli
///```
/// class SomeFirebase extends FirebaseUtils{
/// addCollection(){
///   firestore.collection('collectionPath');
/// }
/// authMethod(){
/// firebaseAuth.signInWithEmailAndPassword(email: email, password: password)
/// }
/// }
///```
