import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final String body;
  final String payload;
  final DateTime timestamp;
  final bool isRead;
  final String userId;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
    required this.timestamp,
    required this.isRead,
    required this.userId,
  });

  @override
  List<Object?> get props =>
      [id, title, body, payload, timestamp, isRead, userId];
}
