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
  bool _isInitialLoad = true;

  TaskNotificationListener({
    required this.remoteDataSource,
    required this.localNotificationService,
    required this.firebaseAuth,
  });

  void startListening(String projectId) {
    _subscription?.cancel();
    _isInitialLoad = true;
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

          // Handle new tasks (added)
          if (change.type == DocumentChangeType.added) {
            // Skip initial load
            if (_isInitialLoad) continue;

            _handleNewTask(task, currentUserId);
          } else if (change.type == DocumentChangeType.modified) {
            _handleModification(task, currentUserId);
          }
        }
        // After processing the first snapshot (even if empty or full), it's no longer initial load
        _isInitialLoad = false;
      },
    );
  }

  void _handleNewTask(TaskModel task, String? currentUserId) {
    // Optional: Don't notify if I created it?
    // if (task.assigneeId == currentUserId) return;

    localNotificationService.showNotification(
      id: task.id.hashCode,
      title: 'New Task: ${task.title}',
      body: 'Priority: ${task.priority.name}',
      payload: '${task.projectId}|${task.id}',
    );
  }

  void _handleModification(TaskModel task, String? currentUserId) {
    // Example logic: Notify if I'm the assignee or if status changed
    localNotificationService.showNotification(
      id: task.id.hashCode,
      title: 'Task Updated: ${task.title}',
      body: 'Status: ${task.status.name}',
      payload: '${task.projectId}|${task.id}',
    );
  }

  void stopListening() {
    _subscription?.cancel();
  }
}
