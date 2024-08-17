import 'dart:async';

class Habit {
  String title;
  final DateTime createDate;
  List<DateTime> completionDates;

  Habit({
    required this.title,
    required this.createDate,
    required this.completionDates,
  });

  // Günün sonu geldiğinde done değeri false olur
  bool get isDoneToday {
    if (completionDates.isEmpty) return false;
    DateTime lastCompletion = completionDates.last;
    return _isSameDay(lastCompletion, DateTime.now());
  }

  // streakCount sadece gün içinde bir kez artar
  int get streakCount {
    if (completionDates.isEmpty) return 0;

    int count = 0;
    for (int i = completionDates.length - 1; i >= 0; i--) {
      if (_isSameDay(
          completionDates[i], DateTime.now().subtract(Duration(days: count)))) {
        count++;
      } else {
        break;
      }
    }
    return count;
  }

  // Alışkanlığı tamamla ve completionDates listesine bugünü ekle
  void completeHabit() {
    DateTime now = DateTime.now();
    if (completionDates.isEmpty || !_isSameDay(completionDates.last, now)) {
      completionDates.add(now);
    }
  }

  // İki tarihi aynı gün olup olmadığını kontrol eder
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

class HabitManager {
  List<Habit> habits;
  late Timer _midnightTimer;

  HabitManager({required this.habits}) {
    _startMidnightTimer();
  }

  // Gece yarısında tüm alışkanlıkların durumunu sıfırlayan timer
  void _startMidnightTimer() {
    DateTime now = DateTime.now();
    DateTime midnight =
        DateTime(now.year, now.month, now.day + 1); // Ertesi gece yarısı
    Duration timeUntilMidnight = midnight.difference(now);

    print("timeUntilMidnight:$timeUntilMidnight  midnight:$midnight now:$now ");

    _midnightTimer = Timer(timeUntilMidnight, _resetHabitsAtMidnight);
  }

  void _resetHabitsAtMidnight() {
    // Tüm alışkanlıkları günceller
    for (var habit in habits) {
      // habit.completionDates.removeLast(); // Bu günü siler, tik kaldırılmış olur
      timer(habit);
    }
    _startMidnightTimer(); // Timer'ı ertesi gece için yeniden başlatır
  }

  void timer(Habit habit) {
    // habit.completeHabit();
    print("${habit.title} completed. Streak: ${habit.streakCount}");
  }

  // Alışkanlığı tamamla ve streak'i güncelle
  void completeHabit(Habit habit) {
    habit.completeHabit();
    print("${habit.title} completed. Streak: ${habit.streakCount}");
  }

  // Uygulama kapatıldığında veya habitler güncellenmek istenirse timer durdurulmalı
  void dispose() {
    _midnightTimer.cancel();
  }
}

void main() {
  Habit habit1 = Habit(
    title: "Exercise",
    createDate: DateTime.now(),
    completionDates: [],
  );

  Habit habit2 = Habit(
    title: "Read",
    createDate: DateTime.now(),
    completionDates: [],
  );

  HabitManager manager = HabitManager(habits: [habit1, habit2]);

  manager.completeHabit(habit1); // Alışkanlığı tamamla
  print(
      "Is ${habit1.title} done today? ${habit1.isDoneToday}"); // Bugün yapıldı mı kontrol et
}
