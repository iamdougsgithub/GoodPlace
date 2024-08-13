import 'package:cloud_firestore/cloud_firestore.dart';

class HabitModel {
  String title;
  String? purpose;
  final DateTime createDate;
  String? imageUrl;
  int streakCount;

  HabitModel(
      {required this.title,
      this.purpose,
      required this.createDate,
      this.imageUrl,
      required this.streakCount});

  // From json
  factory HabitModel.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return HabitModel(
      title: data["title"],
      purpose: data["purpose"],
      createDate: (data['createDate'] as Timestamp).toDate(),
      imageUrl: data['imageUrl'],
      streakCount: data["streakCount"],
    );
  }

  // To json
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'purpose': purpose,
      'createDate': createDate.toUtc(),
      'imageUrl': imageUrl,
      'streakCount': streakCount,
    };
  }
}
