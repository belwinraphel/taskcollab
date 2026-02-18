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
    print('GET NOTIFICATIONS for $userId'); // Debug log
    return firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        // .orderBy('timestamp', descending: true) // Temporarily disabled to avoid Index issues
        .snapshots()
        .map((snapshot) {
      print('GOT SNAPSHOT: ${snapshot.docs.length} docs'); // Debug log
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

      // We let Firestore generate the ID if it's new, but here we might pass an ID.
      // Ideally, we should add without ID to let Firestore generate one,
      // but if we are passing an ID (like task ID), we might want to use that or separate logic.
      // For general notifications, let's use .add() and ignore the passed ID if it's empty or we want auto-ID.
      // However, the model needs an ID.
      // Let's assume createNotification adds a new doc.

      print('ADDING NOTIFICATION TO FIRESTORE: ${model.toJson()}'); // Debug log
      await firestore.collection('notifications').add(model.toJson());
    } catch (e) {
      print('ERROR CREATING NOTIFICATION: $e'); // Debug log
      throw ServerException();
    }
  }
}
