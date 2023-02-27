import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/theme/app_colors.dart';
import 'package:genesis_robotec/app/core/theme/app_theme.dart';
import 'package:overlay_support/overlay_support.dart';

class NotificationService {
  static void negative(
    String label, {
    NotificationPosition position = NotificationPosition.bottom,
  }) =>
      showSimpleNotification(
        Text(
          label,
          style: AppTheme.theme.textTheme.bodyMedium!
              .copyWith(color: Colors.white),
        ),
        background: AppColors.red,
        position: position,
        duration: const Duration(seconds: 3),
      );

  static void positive(
    String label, {
    NotificationPosition position = NotificationPosition.bottom,
  }) =>
      showSimpleNotification(
        Text(
          label,
          style: AppTheme.theme.textTheme.bodyMedium!
              .copyWith(color: Colors.white),
        ),
        background: AppColors.primary,
        position: position,
        duration: const Duration(seconds: 3),
      );

  static void neutral(
    String label, {
    NotificationPosition position = NotificationPosition.bottom,
  }) =>
      showSimpleNotification(
        Text(
          label,
          style: AppTheme.theme.textTheme.bodyMedium!
              .copyWith(color: Colors.white),
        ),
        background: Colors.grey,
        position: position,
        duration: const Duration(seconds: 3),
      );
}
