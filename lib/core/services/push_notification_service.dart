import 'package:firebase_messaging/firebase_messaging.dart';
import 'notification_service.dart';

import '../../features/auth/domain/repositories/auth_repository.dart';

class PushNotificationService implements NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final AuthRepository authRepository;

  PushNotificationService({required this.authRepository});

  @override
  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Foreground message handling
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        // In a real app, you might want to show a local notification here
        // or update the UI directly.
        print('Message also contained a notification: ${message.notification}');
      }
    });

    // Token refresh handling
    _firebaseMessaging.onTokenRefresh.listen((token) {
      authRepository.updateFcmToken(token);
    });
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  // Background message handler must be a top-level function,
  // so it's not defined as an instance method here but passed to
  // FirebaseMessaging.onBackgroundMessage in main.dart or similar.
}
