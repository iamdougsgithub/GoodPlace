import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_place/core/utils/models/habit_model.dart';
import 'package:good_place/features/auth/firebase/authService.dart';

class UserDatabaseService {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

//eğer ileride birden çok kullanıcı etkileşime geçerse currentUserUid kullanma şekli değişmesi gerekebilir.
  String currentUserUid = AuthService().currentUser!.uid;
  //"9PKxVR1p5yRoPvstVzyvXXwQI3q2"; //

  late bool onboardingCompleted;

  CollectionReference getHabitsCollection() {
    return _usersCollection.doc(currentUserUid).collection('habits');
  }

  Future<void> addUser() async {
    try {
      await _usersCollection
          .doc(currentUserUid)
          .set({"onboardingCompleted": false});

      print("Profile added successfully");
    } catch (e) {
      print("Failed to add profile: $e");
    }
  }

  Future<List<HabitModel>> getUserDetails() async {
    if (AuthService().currentUser != null) {
      DocumentSnapshot userDoc =
          await _usersCollection.doc(currentUserUid).get();

      onboardingCompleted = userDoc['onboardingCompleted'];

      List<HabitModel> habits = await getUserHabits();

      return habits;
    }
    return [];
  }

// Şuan için onBoarding güncellemesi için kullanıldı
  Future<bool> updateUserField(String fieldName, dynamic newValue) async {
    try {
      await _usersCollection.doc(currentUserUid).update({fieldName: newValue});
      print('Field updated successfully.');
      return true;
    } catch (e) {
      print('Error updating field: $e');
      return false;
    }
  }

  Future<List<HabitModel>> getUserHabits() async {
    QuerySnapshot habitSnapshot = await _usersCollection
        .doc(currentUserUid)
        .collection('habits')
        .orderBy('streakCount', descending: true)
        .get();

    if (habitSnapshot.docs.isEmpty) {
      return [];
    }

    return habitSnapshot.docs
        .map((doc) => HabitModel.fromSnapshot(doc))
        .toList();
  }

// Habit firebase işlemleri
  Future<String> addHabit(HabitModel habitData) async {
    try {
      DocumentReference docRef = await _usersCollection
          .doc(currentUserUid)
          .collection('habits')
          .add(habitData.toMap());

      print('Habit added successfully.');

      return docRef.id;
    } catch (e) {
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
      updatedFields["completionDates"] =
          FieldValue.arrayUnion([updatedFields["completionDates"]]);

      await getHabitsCollection().doc(habitId).update(updatedFields);
      print('Habit fields updated successfully.');
    } catch (e) {
      print('Error updating habit fields: $e');
    }
  }

  Future<void> deleteHabit(String habitId) async {
    try {
      await getHabitsCollection().doc(habitId).delete();

      print('Habit başarıyla silindi.');
    } catch (e) {
      print('Habit silinirken hata oluştu: $e');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      // Habits koleksiyonundaki tüm dökümanları al
      QuerySnapshot habitsSnapshot = await getHabitsCollection().get();

      for (DocumentSnapshot doc in habitsSnapshot.docs) {
        await deleteHabit(doc.id);
      }

      await _usersCollection.doc(userId).delete();

      print('Kullanıcı ve tüm dökümanlar başarıyla silindi.');
    } catch (e) {
      print('Kullanıcı ve dökümanları silerken hata oluştu: $e');
    }
  }
}
