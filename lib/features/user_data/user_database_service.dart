import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:good_place/core/resourcers/error_texts.dart';
import 'package:good_place/core/resourcers/firebase_utils.dart';
import 'package:good_place/core/utils/models/habit_model.dart';
import 'package:good_place/core/utils/widgets/custom_toast.dart';
import 'package:good_place/features/auth/firebase/authService.dart';
import 'package:good_place/logger.dart';

class UserDatabaseService extends FirebaseUtils {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  // String currentUserUid = AuthService().currentUser!.uid;

  static final String userName =
      AuthService().currentUser?.displayName ?? "User";

  CollectionReference getHabitsCollection() {
    return _usersCollection.doc(uid).collection('habits');
  }

  Future<void> addUser() async {
    try {
      await _usersCollection.doc(uid).set({"onboardingCompleted": true});

      print("Profile added successfully");
    } on FirebaseException catch (firebaseErr) {
      Toast.errToast(
          title: AppErrorText.errorMessageConverter(firebaseErr.code));
    } catch (e) {
      Toast.errToast(title: AppErrorText.errorMessageConverter(e.toString()));
      print("Failed to add profile: $e");
    }
  }

  Future<bool> getUserDetails() async {
    if (AuthService().currentUser != null) {
      DocumentSnapshot userDoc = await _usersCollection.doc(uid).get();

      if (userDoc.exists) {
        // Kullanıcı cloud da var
        return userDoc['onboardingCompleted'] ?? false;
      } else {
        // Kullanıcı yok
        return false;
      }
    }
    return false;
  }

// Şuan için onBoarding güncellemesi için kullanıldı
  Future<bool> updateUserField(String fieldName, dynamic newValue) async {
    try {
      await _usersCollection.doc(uid).update({fieldName: newValue});
      print('Field updated successfully.');
      return true;
    } on FirebaseException catch (firebaseErr) {
      Toast.errToast(
          title: AppErrorText.errorMessageConverter(firebaseErr.code));
      return false;
    } catch (e) {
      print('Error updateUserField: $e');
      Toast.errToast(title: AppErrorText.errorMessageConverter(e.toString()));
      return false;
    }
  }

  Future<List<HabitModel>> getUserHabits() async {
    try {
      QuerySnapshot habitSnapshot = await _usersCollection
          .doc(uid)
          .collection('habits')
          .orderBy('streakCount', descending: true)
          .get();

      if (habitSnapshot.docs.isEmpty) {
        return [];
      }

      return habitSnapshot.docs
          .map((doc) => HabitModel.fromSnapshot(doc))
          .toList();
    } on Exception catch (e) {
      Toast.errToast(title: AppErrorText.errorMessageConverter(e.toString()));
      print('Error getUserHabits: $e');
      return [];
    }
  }

// Habit firebase işlemleri
  Future<String> addHabit(HabitModel habitData) async {
    try {
      DocumentReference docRef = await _usersCollection
          .doc(uid)
          .collection('habits')
          .add(habitData.toMap());

      print('Habit added successfully.');

      return docRef.id;
    } catch (e) {
      Toast.errToast(title: AppErrorText.errorMessageConverter(e.toString()));

      print('Error adding habit: $e');
      return "";
    }
  }

  Future<void> updateHabitFields(
      //tek seferde güncelleme yapıldı
      String habitId,
      Map<String, dynamic> updatedFields) async {
    try {
      /*
      DateTime now = DateTime.now();

      Map<String, dynamic> updatedFields = {
        'completionDates': FieldValue.arrayUnion([now]),
        'title': '""""""Updated Habit Title""""":)))',
      };*/

      // updatedFields["completionDates"] =
      //     FieldValue.arrayUnion([updatedFields["completionDates"]]);

      await getHabitsCollection().doc(habitId).update(updatedFields);
      print('Habit fields updated successfully.');
    } catch (e) {
      Toast.errToast(title: AppErrorText.errorMessageConverter(e.toString()));

      if (kDebugMode) {
        print('Error updating habit fields: $e');
      }
    }
  }

  Future<void> deleteHabit(String habitId) async {
    try {
      await getHabitsCollection().doc(habitId).delete();

      print('Habit başarıyla silindi.');
    } catch (e) {
      Toast.errToast(title: AppErrorText.errorMessageConverter(e.toString()));
      print('Habit silinirken hata oluştu: $e');
    }
  }

  Future<void> deleteUser() async {
    try {
      // Habits koleksiyonundaki tüm dökümanları al
      QuerySnapshot habitsSnapshot = await getHabitsCollection().get();

      for (DocumentSnapshot doc in habitsSnapshot.docs) {
        await deleteHabit(doc.id);
      }

      await _usersCollection.doc(uid).delete();
      await firebaseAuth.currentUser?.delete();
      await firebaseAuth.signOut();
      // print('Kullanıcı ve tüm dökümanlar başarıyla silindi.');
    } on FirebaseAuthException catch (authErr) {
      Toast.errToast(title: AppErrorText.errorMessageConverter(authErr.code));
      logger.e('Kullanıcı ve dökümanları silerken hata oluştu: $authErr');
    } catch (e) {
      Toast.errToast(title: AppErrorText.errorMessageConverter(e.toString()));
      logger.e('Kullanıcı ve dökümanları silerken hata oluştu: $e');
    }
  }
}
