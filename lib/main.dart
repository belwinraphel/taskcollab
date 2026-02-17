import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart' as di;
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/pages/splash_page.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'core/services/local_notification_service.dart';
import 'core/services/push_notification_service.dart';
import 'features/tasks/presentation/pages/project_task_board_page.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ... (Firebase init)
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyA9W-cqWGB4ExrOMxcLW9pSFcRbnXPd_k4',
      appId: 'taskcollabapp-2f3e9',
      messagingSenderId: '926645480265',
      projectId: 'taskcollabapp-2f3e9',
      storageBucket: 'taskcollabapp-2f3e9.firebasestorage.app',
      authDomain: 'taskcollabapp-2f3e9.firebaseapp.com',
      databaseURL: 'https://taskcollabapp-2f3e9-default-rtdb.firebaseio.com',
    ),
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await di.init();

  final localNotificationService = di.getIt<LocalNotificationService>();
  await localNotificationService.initialize();
  await di.getIt<PushNotificationService>().initialize();

  // Listen for notification taps
  localNotificationService.payloadStream.listen((payload) {
    if (payload.contains('|')) {
      final parts = payload.split('|');
      final projectId = parts[0];
      // final taskId = parts[1]; // Can be used to highlight task or open details directly later

      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => ProjectTaskBoardPage(
            projectId: projectId,
            // Project name is unknown here, pass null or fetch it
            projectName: null,
          ),
        ),
      );
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.getIt<AuthBloc>()..add(const AuthEvent.appStarted()),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Task Collab App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
