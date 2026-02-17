import 'package:flutter/material.dart';

class TaskBoardTheme {
  static const Color background = Color(0xFFF4F5F9);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF1D1D1D);
  static const Color textSecondary = Color(0xFF757575);
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color accentBlue = Color(0xFFEBF5FF);

  // Status Colors
  static const Color todoColor = Color(0xFF3B82F6);
  static const Color inProgressColor = Color(0xFF8B5CF6);
  static const Color testingColor = Color(0xFFF59E0B);
  static const Color doneColor = Color(0xFF10B981);

  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static const TextStyle subHeading = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: textSecondary,
  );

  static const TextStyle columnHeader = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: textSecondary,
    letterSpacing: 1.0,
  );
}
