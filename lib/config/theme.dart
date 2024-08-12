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
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.red,
    ),
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
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
        hintStyle: AppTextStyles().textTheme.labelSmall,
      );
}

class AppColors {
  static Color errLight = const Color(0xffEC928E);
  static Color errDark = const Color(0xffB3261E);
  static Color succDark = const Color(0xff2C6D22);

  //Scaffold colors
  /// #FFFFFF
  static const Color authScaffoldColor = Color(0xffFFFFFF);

  /// #8E97FD
  static const Color welcomeScaffoldColor = Color(0xff8E97FD);

  /// #4D57C8
  static const Color homeScaffoldColor = Color(0xff4D57C8);

  // Text Colors
  /// #3F414E
  static const Color darkTextColor = Color(0xff3F414E);

  /// #A1A4B2
  static const Color lightTextColor = Color(0xffA1A4B2);

  /// #FFECCC
  static const Color orangeTextColor = Color(0xffFFECCC);

  /// #EBEAEC
  static const Color grayTextColor = Color(0xFF7B6F72);

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
  static TextStyle font(
          {Paint? background,
          Color? backgroundColor,
          Color? color,
          TextDecoration? decoration,
          Color? decorationColor,
          TextDecorationStyle? decorationStyle,
          double? decorationThickness,
          List<FontFeature>? fontFeatures,
          double? fontSize,
          FontStyle? fontStyle,
          FontWeight? fontWeight,
          Paint? foreground,
          double? height,
          double? letterSpacing,
          Locale? locale,
          List<Shadow>? shadows,
          TextBaseline? textBaseline,
          TextStyle? textStyle,
          double? wordSpacing}) =>
      GoogleFonts.rubik(
        background: background,
        backgroundColor: backgroundColor,
        color: color,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        fontFeatures: fontFeatures,
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        foreground: foreground,
        height: height,
        letterSpacing: letterSpacing,
        locale: locale,
        shadows: shadows,
        textBaseline: textBaseline,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
      );
  TextTheme textTheme = TextTheme(
    titleLarge: font(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.darkTextColor,
    ),
    titleMedium: font(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.darkTextColor,
    ),
    titleSmall: font(
        // fontSize: 20,
        ),
    labelLarge: font(
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    labelSmall: font(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: AppColors.grayTextColor,
    ),
    bodyLarge: font(
      foreground: Paint()..color = AppColors.homeScaffoldColor,
      // color: Colors.red,
      fontSize: 16,
    ),
    bodyMedium: font(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.grayTextColor,
    ),
  );
}
