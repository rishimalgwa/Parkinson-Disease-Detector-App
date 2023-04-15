import 'package:flutter/material.dart';
import 'package:pkd_app/src/common/theme/app_colors.dart';

SnackBar successSnackbar(String message) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    duration: const Duration(seconds: 5),
    backgroundColor: Colors.greenAccent,
    behavior: SnackBarBehavior.floating,
    elevation: 2.0,
  );
}

SnackBar errorSnackbar(String message) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    duration: const Duration(seconds: 5),
    backgroundColor: AppColors.redColor,
    behavior: SnackBarBehavior.floating,
    elevation: 2.0,
  );
}
