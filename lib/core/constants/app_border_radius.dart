import 'package:flutter/material.dart';

class AppBorderRadius {
  /// TextField'lar için kullanılan border radius
  /// BorderRadius value : 15
  static BorderRadius textFieldBorderRadius =
      BorderRadius.circular(textFieldBorderRadiusValue);

  /// xSmall circular border radius
  /// value : 8px
  static BorderRadius xsmallBorderRadius =
      BorderRadius.circular(xxsmallBorderRadiusValue);

  /// Small circular border radius
  /// value : 10px
  static BorderRadius smallBorderRadius =
      BorderRadius.circular(xsmallBorderRadiusValue);

  /// Medium circular border radius
  /// value : 22px
  static BorderRadius mediumBorderRadius =
      BorderRadius.circular(mediumBorderRadiusValue);

  /// Large circular border radius
  /// value : 30px
  static BorderRadius largeBorderRadius =
      BorderRadius.circular(largeBorderRadiusValue);

  static const double textFieldBorderRadiusValue = 15.0;
  static const double xxsmallBorderRadiusValue = 8.0;
  static const double xsmallBorderRadiusValue = 10.0;
  static const double smallBorderRadiusValue = 16.0;
  static const double mediumBorderRadiusValue = 22.0;
  static const double largeBorderRadiusValue = 30.0;
}
