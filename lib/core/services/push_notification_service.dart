import 'package:firebase_messaging/firebase_messaging.dart';
import 'notification_service.dart';
import 'local_notification_service.dart';

import '../../features/auth/domain/repositories/auth_repository.dart';

class PushNotificationService implements NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final AuthRepository authRepository;
  final LocalNotificationService localNotificationService;

  PushNotificationService({
    required this.authRepository,
    required this.localNotificationService,
  });

  @override
  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Foreground message handling
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        localNotificationService.showNotification(
          id: message.hashCode,
          title: message.notification!.title ?? 'New Notification',
          body: message.notification!.body ?? '',
          // Assuming an optional payload string in data
          payload: message.data['payload'],
        );
      }
    });

    // Token refresh handling
    _firebaseMessaging.onTokenRefresh.listen((token) {
      authRepository.updateFcmToken(token);
    });
  }

  Future<void> registerTokenAndListen() async {
    final token = await getToken();
    if (token != null) {
      await authRepository.updateFcmToken(token);
    }
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  // Background message handler must be a top-level function,
  // so it's not defined as an instance method here but passed to
  // FirebaseMessaging.onBackgroundMessage in main.dart or similar.
}
