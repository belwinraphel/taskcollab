import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/exceptions.dart';
import '../models/notification_model.dart';
import '../../domain/entities/notification.dart';

abstract class NotificationRemoteDataSource {
  Stream<List<NotificationModel>> getNotifications(String userId);
  Future<void> markAsRead(String notificationId);
  Future<void> createNotification(NotificationEntity notification);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final FirebaseFirestore firestore;

  NotificationRemoteDataSourceImpl(this.firestore);

  @override
  Stream<List<NotificationModel>> getNotifications(String userId) {
    return firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        // .orderBy('timestamp', descending: true) // Temporarily disabled to avoid Index issues
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => NotificationModel.fromFirestore(doc))
          .toList();
    });
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      await firestore
          .collection('notifications')
          .doc(notificationId)
          .update({'isRead': true});
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> createNotification(NotificationEntity notification) async {
    try {
      final model = NotificationModel(
        id: notification.id,
        title: notification.title,
        body: notification.body,
        payload: notification.payload,
        timestamp: notification.timestamp,
        isRead: notification.isRead,
        userId: notification.userId,
      );

      await firestore.collection('notifications').add(model.toJson());
    } catch (e) {
      throw ServerException();
    }
  }
}
