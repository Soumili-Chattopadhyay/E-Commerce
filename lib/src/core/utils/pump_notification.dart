import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PumpNotificationType {
  success,
  warning,
  error,
}

void pumpNotification(PumpNotificationType notifyType,
    {required String message}) {
  Color? backgroundColor;
  Icon? icon = const Icon(Icons.upload_rounded);
  String? title;

  switch (notifyType) {
    case PumpNotificationType.success:
      backgroundColor = Colors.lightGreen;
      icon = const Icon(Icons.done_rounded);
      title = 'SUCCESS';
      break;
    case PumpNotificationType.warning:
      backgroundColor = Colors.orange;
      icon = const Icon(Icons.warning_rounded);
      title = 'WARNING';
      break;
    case PumpNotificationType.error:
      backgroundColor = Colors.red;
      icon = const Icon(Icons.close_rounded);
      title = 'ERROR';
      break;
  }

  Get.showSnackbar(
    GetSnackBar(
      backgroundColor: backgroundColor,
      icon: icon,
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
      borderRadius: 8.0,
      isDismissible: true,
      margin: const EdgeInsets.all(10.0),
      snackPosition: SnackPosition.TOP,
    ),
  );
}
