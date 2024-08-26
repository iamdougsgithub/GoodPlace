import 'package:cloud_firestore/cloud_firestore.dart';

class HabitModel {
  String? id;
  String title;
  String? purpose;
  final DateTime createDate;
  String? imageUrl;
  int streakCount;
  List<DateTime> completionDates;
  bool done;
  int longestStreak;

  HabitModel({
    this.id,
    required this.title,
    this.purpose,
    required this.createDate,
    this.imageUrl,
    required this.streakCount,
    required this.longestStreak,
    required this.completionDates,
  }) : done = _calculateDone(completionDates) {
    _updateStreakCount();
  }

  void _updateStreakCount() {
    if (completionDates.isNotEmpty) {
      final lastCompletionDate = stripTime(completionDates.last);

      final now = stripTime(DateTime.now());

      final difference = now.difference(lastCompletionDate).inDays;
      if (difference > 1) {
        streakCount = 0;
      }
    }
  }

  static _calculateDone(List<DateTime> completionDates) {
    if (completionDates.isEmpty) return false;
    final today = stripTime(DateTime.now());

    final lastCompletionDate = stripTime(completionDates.last);

    return lastCompletionDate == today;
  }

  /// Strips the time part from a DateTime object, leaving only the date
  static DateTime stripTime(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  // From json
  factory HabitModel.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return HabitModel(
      id: snapshot.id,
      title: data["title"],
      purpose: data["purpose"],
      createDate: (data['createDate'] as Timestamp).toDate(),
      imageUrl: data['imageUrl'] ?? "",
      streakCount: data["streakCount"],
      completionDates: (data['completionDates'] as List<dynamic>?)
              ?.map((timestamp) => (timestamp as Timestamp).toDate())
              .toList() ??
          [],
      longestStreak: data["longestStreak"] ?? 0,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'purpose': purpose,
      'createDate': Timestamp.fromDate(createDate),
      'imageUrl': imageUrl,
      'streakCount': streakCount,
      'completionDates': completionDates.isNotEmpty
          ? completionDates.map((date) => Timestamp.fromDate(date)).toList()
          : [],
      'longestStreak': longestStreak,
    };
  }

// "title:Koşu,purpose:günde 30 dk koşmak,mevcut streakCount:10,longestStreak:100,bugün ki görevimi yaptım."
  @override
  String toString() {
    String doneStatus = done
        ? "bugün ki görevimi yaptım."
        : "bugün ki görevimi henüz yapmadım.";
    String purposeText = purpose != null ? "purpose:$purpose," : "";

    return "Alışkanlık title:$title,$purposeText mevcut streakCount:$streakCount,longestStreak:$longestStreak,$doneStatus";
  }
}
