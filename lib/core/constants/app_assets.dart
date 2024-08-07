import 'package:flutter/material.dart';

part "enums/assets_path_enum.dart";

class AppAssets {
  static String googleIcon = _AssetsPathEnum.googleIcon.path;
  static String averagePerDailyCardIcon =
      _AssetsPathEnum.averagePerDailyCardIcon.path;
  static String bg = _AssetsPathEnum.welcomePageImage.path;

  /// TODO : Bunlara renk ekle
  static Widget chartIcon = const Icon(Icons.show_chart);
  static Widget calendarIcon = const Icon(Icons.calendar_today_outlined);
  static Widget checkIcon = const Icon(Icons.check);
}
