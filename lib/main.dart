import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/di/injection_container.dart' as di;
import 'core/services/firebase_messaging_handler.dart';
import 'core/services/local_notification_service.dart';
import 'core/services/push_notification_service.dart';
import 'features/tasks/presentation/pages/project_task_board_page.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await di.init();
  await _setupNotifications();

  runApp(MyApp(navigatorKey: navigatorKey));
}

Future<void> _setupNotifications() async {
  final localNotificationService = di.getIt<LocalNotificationService>();

  await localNotificationService.initialize();
  await di.getIt<PushNotificationService>().initialize();

  localNotificationService.payloadStream.listen((payload) {
    if (payload.contains('|')) {
      final parts = payload.split('|');
      final projectId = parts[0];

      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => ProjectTaskBoardPage(
            projectId: projectId,
            projectName: null,
          ),
        ),
      );
    }
  });
}
