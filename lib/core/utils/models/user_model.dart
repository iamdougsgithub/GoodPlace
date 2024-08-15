import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_place/core/utils/models/habit_model.dart';

class UserModel {
  final String? id;
  final String email;
  final String name;
  bool onboardingCompleted;
  List<HabitModel>? habits;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.onboardingCompleted,
    this.habits,
  });

  // From json
  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final map = snapshot.data() as Map<String, dynamic>;
    return UserModel(
        id: snapshot.id,
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        onboardingCompleted: map['onboardingCompleted'],
        habits: map['habits'] != null
            ? List<HabitModel>.from(
                map['habits'].map((habit) => HabitModel.fromSnapshot(habit)))
            : []);
  }

  // To json
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'onboardingCompleted': onboardingCompleted,
      'habits':
          habits != null ? habits!.map((habit) => habit.toJson()).toList() : [],
    };
  }
}
