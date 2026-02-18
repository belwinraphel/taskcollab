import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/notification.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.payload,
    required super.timestamp,
    required super.isRead,
    required super.userId,
  });

  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      id: doc.id,
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      payload: data['payload'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      isRead: data['isRead'] ?? false,
      userId: data['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'payload': payload,
      'timestamp': Timestamp.fromDate(timestamp),
      'isRead': isRead,
      'userId': userId,
    };
  }
}
