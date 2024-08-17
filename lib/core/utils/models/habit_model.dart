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
  /*
  TODO:
  
  en uzun streakCount sayısını alan olarak firebase de tutmak mı?

  yoksa completionDates e bakıp her uygulamayı açtığımda en uzun zinciri hesaplasam mı?

  */

  HabitModel({
    this.id,
    required this.title,
    this.purpose,
    required this.createDate,
    this.imageUrl,
    required this.streakCount,
    required this.completionDates,
  }) : done = _calculateDone(completionDates);

  static bool _calculateDone(List<DateTime> completionDates) {
    if (completionDates.isEmpty) return false;

    final lastCompletionDate = completionDates.last;
    print("lastCompletionDate:$lastCompletionDate");
    final today = DateTime.now();

    return lastCompletionDate.day == today.day &&
        lastCompletionDate.month == today.month &&
        lastCompletionDate.year == today.year;
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
    };
  }
}
