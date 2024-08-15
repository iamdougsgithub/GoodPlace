import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_place/core/utils/models/user_model.dart';

class UserDatabaseService {
  // Create a CollectionReference called users that references the firestore collection
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(UserModel user) async {
    try {
      await _usersCollection.doc('deneme14@gmail.com').set(user.toJson());
      print("Profile added successfully");
    } catch (e) {
      print("Failed to add profile: $e");
    }
  }

  Future<UserModel?> getUser(String email) async {
    try {
      DocumentSnapshot snapshot =
          await _usersCollection.doc("deneme14@gmail.com").get();
      if (snapshot.exists) {
        return UserModel.fromSnapshot(snapshot);
      }
    } catch (e) {
      print('Error getting user: $e');
    }
    return null;
  }
}
