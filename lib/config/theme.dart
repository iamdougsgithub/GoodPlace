import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_border_radius.dart';

class AppTheme {
  final ThemeData theme = ThemeData(
    textTheme: TextTheme(),
    inputDecorationTheme: _inputDecorationTheme,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: GoogleFonts.rubik(
          color: AppColors.darkTextColor,
        ),
      ),
    ),
  );

  static InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: AppColors.textFieldFillColor,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: AppBorderRadius.textFieldBorderRadius,
        ),
        labelStyle: GoogleFonts.rubik(
          color: AppColors.lightTextColor,
        ),
        hintStyle: GoogleFonts.rubik(color: AppColors.darkTextColor),
      );
}

class AppColors {
  //Scaffold colors
  static const Color authScaffoldColor = Color(0xffFFFFFF);
  static const Color welcomeScaffoldColor = Color(0xff8E97FD);

  // Text Colors
  static const Color darkTextColor = Color(0xff3F414E);
  static const Color lightTextColor = Color(0xffA1A4B2);
  static const Color orangeTextColor = Color(0xffFFECCC);
  static const Color grayTextColor = Color(0xffEBEAEC);

  /// Widget Colors
  // Button Colors
  static const Color primaryButtonColor = Color(0xff8E97FD);
  static const Color secondaryButtonColor = Color(0xffEBEAEC);
  // TextField colors
  static const Color textFieldFillColor = Color(0xffF2F3F7);
}

class AppTextStyles {}
