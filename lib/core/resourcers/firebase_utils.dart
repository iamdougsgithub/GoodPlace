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
abstract class FirebaseUtils {
  /// Daha Firebase'i kurmadığımız için burayı şimdilik comment'e aldım
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // User? get currentUser => firebaseAuth.currentUser;
  // final FirebaseStorage storage = FirebaseStorage.instance;

  // /// UID of current user
  // String? get uid => firebaseAuth.currentUser?.uid;
}
