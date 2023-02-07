import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    dividerColor: AppColors.grey[100],
    primaryColor: AppColors.primary,
    inputDecorationTheme: const InputDecorationTheme(),
    textTheme: textTheme,
    fontFamily: 'SpaceGrotesk'
  );
  static TextTheme get text => theme.textTheme;

  static TextTheme textTheme = TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
  );

  static TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
    color: AppColors.grey,
  );
  static TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
    color: AppColors.grey,
  );
  static TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: AppColors.grey,
  );
  static TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
    color: AppColors.grey,
  );
  static TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
    color: AppColors.grey,
  );
  static TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
    color: AppColors.grey,
  );
  static TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: AppColors.grey,
  );
  static TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: AppColors.grey,
  );
  static TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: AppColors.grey,
    letterSpacing: 1,
  );
  static TextStyle labelLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'Inter',
    color: AppColors.grey,
  );
  static TextStyle labelMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Inter',
    color: AppColors.grey,
  );
  static TextStyle labelSmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    fontFamily: 'Inter',
    color: AppColors.grey,
  );
  static TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter',
    color: AppColors.grey,
  );
  static TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter',
    color: AppColors.grey,
  );
  static TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter',
    color: AppColors.grey,
  );

  static BoxDecoration get boxDecorated => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [BoxShadow(color: Colors.grey[200]!, blurRadius: 4)],
      );

  static List<BoxShadow> shadow = [
    BoxShadow(color: Colors.grey[400]!, blurRadius: 2)
  ];
}
