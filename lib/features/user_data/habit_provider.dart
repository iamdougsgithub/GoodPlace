import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:good_place/core/utils/models/habit_model.dart';
import 'package:good_place/features/user_data/user_database_service.dart';

class HabitProvider with ChangeNotifier {
  HabitProvider();
  List<HabitModel> _habits = [];

  static HabitProvider instance = HabitProvider();

  List<HabitModel> get habits => _habits;

  final UserDatabaseService _userService = UserDatabaseService();

  Timer? _midnightTimer;

  Future<void> getHabits() async {
    _habits = await _userService.getUserHabits();
    if (_midnightTimer == null) {
      _startMidnightTimer();
    }
    notifyListeners();
  }

  Future<void> addHabit(HabitModel habit) async {
    habit.id = await _userService
        .addHabit(habit); // bu HabitModel örnek amaçlı koyuldu kaldırılacak.

    if (habit.id!.isNotEmpty) {
      _habits.add(habit);
      notifyListeners();
    } else {
      print("Ekelem yapılamadı bir hata oluştu.");
      print("Buraya bir uyarı-hata mesajı eklenebilir");
    }
  }

// Habitin başka bir özelliği daha güncellenmek istenirse diye map değeri alınmaktadır.
// Yoksa sadece streakCount,completionDates değerlerini değiştirebiliriz.
//update: streakCount ve completionDates e bugünün tarihi eklenecek
  Future<void> updateHabit(
    String habitId,
  ) async {
    int index = _habits.indexWhere((h) => h.id == habitId);

    DateTime now = DateTime.now();

    Map<String, dynamic> updatedFields = {
      'completionDates': FieldValue.arrayUnion([now]),
      'streakCount': _habits[index].streakCount++,
    };

    _userService.updateHabitFields(habitId, updatedFields);

    _habits[index].completionDates.add(now); // burası değişecek
    _habits[index].done = true; // burası değişecek
    _habits[index].streakCount = updatedFields["streakCount"];
    notifyListeners();
  }

  // Habit sil
  Future<void> deleteHabit(String habitId) async {
    await _userService.deleteHabit(habitId);

    _habits.removeWhere((habit) => habit.id == habitId);
    notifyListeners();
  }

  // Gece yarısında tüm alışkanlıkların done durumunu sıfırlayan timer
  void _startMidnightTimer() {
    DateTime now = DateTime.now();
    DateTime midnight =
        DateTime(now.year, now.month, now.day + 1); // Ertesi gece yarısı
    Duration timeUntilMidnight = midnight.difference(now);

    // print("timeUntilMidnight:$timeUntilMidnight  midnight:$midnight now:$now ");

    _midnightTimer = Timer(timeUntilMidnight, _resetHabitsAtMidnight);
  }

  void _resetHabitsAtMidnight() {
    _habits.forEach((habit) {
      habit.done = false;
    });
    notifyListeners();
    _startMidnightTimer(); // Timer'ı ertesi gece için yeniden başlat
  }

  @override
  void dispose() {
    super.dispose();
    _midnightTimer?.cancel();
  }
}
