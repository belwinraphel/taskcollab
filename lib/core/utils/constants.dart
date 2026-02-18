import 'package:flutter/material.dart';

class KanbanConstants {
  // Colors
  static const Color boardBackground = Color(0xFFF5F5F5);
  static const Color columnBackground = Color(0xFFF3F4F6);
  static const Color headerText = Color(0xFF4B5563);
  static const Color countBackground = Color(0xFFE5E7EB);
  static const Color countText = Color(0xFF6B7280);

  // Card Colors
  static const Color cardTitle = Color(0xFF1D1D1D);
  static const Color cardDescription = Color(0xFF757575);
  static const Color cardDateText = Color(0xFF9CA3AF);
  static const Color cardShadow = Colors.black12;
  static const Color remainingCountBackground = Color(0xFFE0E0E0);
  static const Color avatarRemainingText = Colors.black54;

  // Status Colors
  static const Color statusTodo = Colors.blue;
  static const Color statusInProgress = Colors.orange;
  static const Color statusDone = Colors
      .green; // Colors.purple was used in some places, now standardizing on green?
  // Wait, in previous edits I saw:
  // case TaskStatus.done: return KanbanConstants.statusDone;
  // And KanbanConstants.statusDone = Colors.green;
  // But inside ProjectTaskBoardPage overview cards, it said "Using purple for done/history".
  // I should check if I should stick to Green or Purple.
  // The user approved my previous plan.
  // I'll stick to what is currently in KanbanConstants (Green).

  // Priority Colors
  static const Color priorityLow = Colors.green;
  static const Color priorityMedium = Colors.orange;
  static const Color priorityHigh = Colors.red;

  // Zoom Controls
  static const Color zoomTextBackground = Colors.black54;
  static const Color zoomTextColor = Colors.white;
  static const Color zoomControlBackground = Colors.white;
  static const Color zoomIconColor = Colors.blueGrey;

  // Project Board Page
  static const Color listViewBackground = Color(0xFFF9FAFB);
  static const Color listTitleText = Color(0xFF9CA3AF);
  static const Color activeCountBackground = Color(0xFFDBEAFE);
  static const Color activeCountText = Color(0xFF3B82F6);
  static const Color overviewHeaderText = Color(0xFF9CA3AF);
  static const Color iconAdd = Color(0xFFD1D5DB);
  static const Color iconSearch = Color(0xFFD1D5DB);
  static const Color iconBlue = Colors.blue;
  static const Color headerBorder = Color(0xFFE5E7EB);
  static const Color phaseText = Color(0xFF9CA3AF);

  // Strings
  static const String titleTodo = 'To Do';
  static const String titleInProgress = 'In Progress';
  static const String titleDone = 'Done';

  static const String tooltipResetZoom = 'Reset Zoom';
  static const String tooltipZoomIn = 'Zoom In';
  static const String tooltipZoomOut = 'Zoom Out';
}

class Constants {
  static String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }
}
