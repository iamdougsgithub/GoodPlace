import '../../../config/theme.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toast {
  /// Error Toast
  static ToastificationItem errToast(
    String? title,
    String? desc, {
    bool dismissible = true,
    AlignmentGeometry alignment = Alignment.bottomCenter,
    EdgeInsetsGeometry? margin,
  }) =>
      toastification.show(
        title: Text(title ?? ""),
        description: Text(desc ?? ""),
        alignment: alignment,
        backgroundColor: AppColors.errDark,
        borderSide: BorderSide.none,
        dragToClose: dismissible,
        autoCloseDuration: dismissible ? const Duration(seconds: 3) : null,
        showProgressBar: false,
        showIcon: false,
        foregroundColor: AppColors.secondaryButtonColor,
        closeButtonShowType: CloseButtonShowType.none,
        // style: ToastificationStyle.fillColored,
        margin: margin,
      );

  static ToastificationItem succToast(
    String? title,
    String? desc, {
    bool dismissible = true,
    AlignmentGeometry alignment = Alignment.bottomCenter,
    EdgeInsetsGeometry? margin,
  }) =>
      toastification.show(
        title: Text(title ?? ""),
        description: Text(desc ?? ""),
        alignment: alignment,
        backgroundColor: AppColors.succDark,
        borderSide: BorderSide.none,
        dragToClose: dismissible,
        autoCloseDuration: dismissible ? const Duration(seconds: 3) : null,
        showProgressBar: false,
        showIcon: false,
        foregroundColor: AppColors.secondaryButtonColor,
        closeButtonShowType: CloseButtonShowType.none,
        // style: ToastificationStyle.fillColored,
        margin: margin,
      );
}
