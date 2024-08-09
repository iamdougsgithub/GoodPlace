import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_border_radius.dart';

class AppTheme {
  final ThemeData theme = ThemeData(
    textTheme: AppTextStyles().textTheme,
    inputDecorationTheme: _inputDecorationTheme,
    outlinedButtonTheme: _outlinedButtonTheme(),
    filledButtonTheme: _filledButtonTheme(),
    textButtonTheme: _textButtonTheme(),
    checkboxTheme: _checkBoxTheme(),
  );

  static CheckboxThemeData _checkBoxTheme() {
    return CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      side: const BorderSide(
        color: AppColors.lightTextColor,
        width: 2,
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.darkTextColor,
      ),
    );
  }

  static FilledButtonThemeData _filledButtonTheme() {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        foregroundColor: AppColors.primaryButtonTextColor,
      ),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.darkTextColor,
          alignment: Alignment.center,
          side: const BorderSide(color: AppColors.secondaryButtonColor)),
    );
  }

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
  /// #FFFFFF
  static const Color authScaffoldColor = Color(0xffFFFFFF);

  /// #8E97FD
  static const Color welcomeScaffoldColor = Color(0xff8E97FD);

  // Text Colors
  /// #3F414E
  static const Color darkTextColor = Color(0xff3F414E);

  /// #A1A4B2
  static const Color lightTextColor = Color(0xffA1A4B2);

  /// #FFECCC
  static const Color orangeTextColor = Color(0xffFFECCC);

  /// #EBEAEC
  static const Color grayTextColor = Color(0xffEBEAEC);

  /// #F6F1FB
  static const Color primaryButtonTextColor = Color(0xffF6F1FB);

  /// Widget Colors
  // Button Colors
  /// #8E97FD
  static const Color primaryButtonColor = Color(0xff8E97FD);

  /// #EBEAEC
  static const Color secondaryButtonColor = Color(0xffEBEAEC);
  // TextField colors
  /// #F2F3F7
  static const Color textFieldFillColor = Color(0xffF2F3F7);
}

class AppTextStyles {
  TextTheme textTheme = TextTheme(
    titleLarge: GoogleFonts.rubik(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.darkTextColor,
    ),
    labelLarge: GoogleFonts.rubik(
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
  );
}
