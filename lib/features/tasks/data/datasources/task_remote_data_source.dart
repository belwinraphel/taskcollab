import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/exceptions.dart';
import '../models/task_model.dart';
// Needed for TaskStatus enum maybe? No, derived from model.

abstract class TaskRemoteDataSource {
  Stream<List<TaskModel>> getTasks(String projectId, {int limit = 100});
  Stream<QuerySnapshot<Map<String, dynamic>>> getTaskSnapshots(
      String projectId);
  Future<TaskModel> createTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String projectId, String taskId);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final FirebaseFirestore firestore;

  TaskRemoteDataSourceImpl(this.firestore);

  @override
  Stream<List<TaskModel>> getTasks(String projectId, {int limit = 100}) {
    return firestore
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .orderBy('status') // Simple ordering
        .limit(limit)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => TaskModel.fromFirestore(doc)).toList());
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getTaskSnapshots(
      String projectId) {
    return firestore
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .orderBy('status')
        .snapshots();
  }

  @override
  Future<TaskModel> createTask(TaskModel task) async {
    try {
      final docRef = await firestore
          .collection('projects')
          .doc(task.projectId)
          .collection('tasks')
          .add(task.toFirestore());
      final doc = await docRef.get();
      return TaskModel.fromFirestore(doc);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      await firestore
          .collection('projects')
          .doc(task.projectId)
          .collection('tasks')
          .doc(task.id)
          .update(task.toFirestore());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteTask(String projectId, String taskId) async {
    try {
      await firestore
          .collection('projects')
          .doc(projectId)
          .collection('tasks')
          .doc(taskId)
          .delete();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
