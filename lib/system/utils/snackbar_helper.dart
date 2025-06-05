import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackbarType { success, error, info }

void showCustomSnackbar(
  BuildContext context, {
  required String title,
  required String message,
  SnackbarType type = SnackbarType.info,
  SnackPosition position = SnackPosition.BOTTOM,
  Duration duration = const Duration(seconds: 3),
}) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  IconData icon;
  Color backgroundColor;
  Color textColor;

  switch (type) {
    case SnackbarType.success:
      icon = Icons.check_circle;
      backgroundColor = colorScheme.primary;
      textColor = colorScheme.onPrimary;
      break;
    case SnackbarType.error:
      icon = Icons.error;
      backgroundColor = colorScheme.error;
      textColor = colorScheme.onError;
      break;
    case SnackbarType.info:
      icon = Icons.info;
      backgroundColor = colorScheme.secondary;
      textColor = colorScheme.onSecondary;
      break;
  }

  Get.snackbar(
    title,
    message,
    snackPosition: position,
    backgroundColor: backgroundColor,
    colorText: textColor,
    margin: const EdgeInsets.all(12),
    borderRadius: 10,
    icon: Icon(icon, color: textColor),
    snackStyle: SnackStyle.FLOATING,
    duration: duration,
    isDismissible: true,
  );
}

void showSuccessSnackbar(
  BuildContext context,
  String message, {
  String title = "نجاح",
}) {
  showCustomSnackbar(
    context,
    title: title,
    message: message,
    type: SnackbarType.success,
  );
}

void showErrorSnackbar(
  BuildContext context,
  String message, {
  String title = "خطأ",
}) {
  showCustomSnackbar(
    context,
    title: title,
    message: message,
    type: SnackbarType.error,
  );
}

void showInfoSnackbar(
  BuildContext context,
  String message, {
  String title = "معلومات",
}) {
  showCustomSnackbar(
    context,
    title: title,
    message: message,
    type: SnackbarType.info,
  );
}
