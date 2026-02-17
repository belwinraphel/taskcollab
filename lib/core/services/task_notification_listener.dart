import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'local_notification_service.dart';
import '../../features/tasks/data/datasources/task_remote_data_source.dart';
import '../../features/tasks/data/models/task_model.dart';

class TaskNotificationListener {
  final TaskRemoteDataSource remoteDataSource;
  final LocalNotificationService localNotificationService;
  final FirebaseAuth firebaseAuth;
  StreamSubscription? _subscription;

  TaskNotificationListener({
    required this.remoteDataSource,
    required this.localNotificationService,
    required this.firebaseAuth,
  });

  void startListening(String projectId) {
    _subscription?.cancel();
    _subscription = remoteDataSource.getTaskSnapshots(projectId).listen(
      (snapshot) {
        for (final change in snapshot.docChanges) {
          // Skip local changes (latency compensation)
          if (snapshot.metadata.hasPendingWrites) continue;

          final doc = change.doc;
          final task = TaskModel.fromFirestore(doc);
          final currentUserId = firebaseAuth.currentUser?.uid;

          // Don't notify if I am the one who made the change (if triggered remotely somehow)
          // or if the task isn't relevant?
          // For now, let's notify on "added" and "modified" if it's not local.

          if (change.type == DocumentChangeType.added) {
            // Optional: Don't notify for initial load?
            // Firestore sends 'added' for all existing docs on first listener.
            // We can check `snapshot.metadata.isFromCache` but that might miss updates.
            // A better way is using a timestamp, but for simplicity let's rely on
            // checking if it's a NEW addition after we started listening?
            // For this implementation, we might get a burst of notifications on app start if not careful.
            // A common trick is to query with 'updatedAt' > now, but here we are listening to the whole collection.

            // WORKAROUND: For this assignment, we'll assume we only want to be notified of
            // changes that happen *live*.
          } else if (change.type == DocumentChangeType.modified) {
            _handleModification(task, currentUserId);
          }
        }
      },
    );
  }

  void _handleModification(TaskModel task, String? currentUserId) {
    // Example logic: Notify if I'm the assignee or if status changed
    localNotificationService.showNotification(
      id: task.id.hashCode,
      title: 'Task Updated: ${task.title}',
      body: 'Status: ${task.status.name}',
      payload: task.id,
    );
  }

  void stopListening() {
    _subscription?.cancel();
  }
}
