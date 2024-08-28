import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:good_place/core/utils/models/habit_model.dart';
import 'package:good_place/core/utils/widgets/custom_toast.dart';
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
    if (_midnightTimer == null && _habits.isNotEmpty) {
      _startMidnightTimer();
    }
    notifyListeners();
  }

  Future<void> addHabit(HabitModel habit) async {
    habit.id = await _userService.addHabit(habit);

    if (habit.id!.isNotEmpty) {
      if (_midnightTimer == null && _habits.isEmpty) {
        _startMidnightTimer();
      }
      _habits.add(habit);
      notifyListeners();
    } else {
      Toast.errToast(title: "Something went wrong!", desc: "Please try again.");
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
    _habits[index].streakCount += 1;
    if (_habits[index].streakCount > _habits[index].longestStreak) {
      _habits[index].longestStreak = _habits[index].streakCount;
    }

    Map<String, dynamic> updatedFields = {
      'completionDates': FieldValue.arrayUnion([now]),
      'streakCount': (_habits[index].streakCount),
      'longestStreak': (_habits[index].longestStreak),
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

  ///  =>>>>>>>>>>>  Home page calculation cards operations
  int getTotalDone() {
    return _habits.where((habit) => habit.done).length;
  }

  int getLongestStreak() {
    int longestStreak = 0;

    for (var habit in _habits) {
      if (habit.longestStreak > longestStreak) {
        longestStreak = habit.longestStreak;
      }
    }
    return longestStreak;
  }

  String getLongestMissedHabitInfo() {
    //en uzun süredir yapılmamış habit
    if (_habits.isEmpty) {
      return 'No habits available';
    }

    HabitModel? longestMissedHabit;
    Duration longestMissedDuration = Duration.zero;

    for (var habit in _habits) {
      if (habit.completionDates.isEmpty) {
        return 'Title: ${habit.title}\nLast Completed: Never';
      }
      var lastCompletionDate = habit.completionDates.last;
      var durationSinceLastCompletion =
          DateTime.now().difference(lastCompletionDate);

      if (durationSinceLastCompletion > longestMissedDuration) {
        longestMissedDuration = durationSinceLastCompletion;
        longestMissedHabit = habit;
      }
    }

    if (longestMissedHabit != null) {
      var lastCompletionDate = longestMissedHabit.completionDates.last;
      return 'Title: ${longestMissedHabit.title}\nLast Completed: ${_formatDate(lastCompletionDate)}';
    }

    return 'No valid habit found';
  }

  String _formatDate(DateTime date) {
    return '${date.day}-${date.month}-${date.year}';
  }

  //// =>>>>>>>>>>>    Sort operations

  /// Sort habits by streak count
  void sortByStreakCount() {
    _habits.sort((a, b) => b.streakCount.compareTo(a.streakCount));
    notifyListeners();
  }

  /// Sort habits by Longest streak
  void sortByLongestStreak() {
    _habits.sort((a, b) => b.longestStreak.compareTo(a.longestStreak));
    notifyListeners();
  }

  /// Sort habits by date of last completion
  void sortByRecentCompletion() {
    _habits.sort((a, b) {
      if (a.completionDates.isNotEmpty && b.completionDates.isNotEmpty) {
        return b.completionDates.last.compareTo(a.completionDates.last);
      } else if (a.completionDates.isNotEmpty) {
        return -1;
      } else if (b.completionDates.isNotEmpty) {
        return 1;
      }
      return 0;
    });
    notifyListeners();
  }

  /// Sort habits by streakCount and then by date of last completion
  void sortByStreakCountAndRecentCompletion() {
    _habits.sort((a, b) {
      int streakComparison = b.streakCount.compareTo(a.streakCount);
      if (streakComparison != 0) {
        return streakComparison;
      }
      if (a.completionDates.isNotEmpty && b.completionDates.isNotEmpty) {
        return b.completionDates.last.compareTo(a.completionDates.last);
      } else if (a.completionDates.isNotEmpty) {
        return -1;
      } else if (b.completionDates.isNotEmpty) {
        return 1;
      }
      return 0;
    });
    notifyListeners();
  }

  /// All Completion Dates for HomePage Calender
  /// örnek kullanım:
  /// final habitsProvider = Provider.of<HabitsProvider>(context);
  ///  final allDates = habitsProvider.allCompletionDates;

  List<DateTime> get allCompletionDates {
    Set<DateTime> dates = {};
    for (var habit in _habits) {
      for (var date in habit.completionDates) {
        dates.add(HabitModel.stripTime(date));
      }
    }
    return dates.toList()..sort();
  }

  // Get all Habit Tostring
  String getAllHabitInformation() {
    String combinedString = '';
    for (int i = 0; i < _habits.length; i++) {
      combinedString += '${i + 1}. ${_habits[i].toString()}\n';
    }
    return combinedString;
  }
}
