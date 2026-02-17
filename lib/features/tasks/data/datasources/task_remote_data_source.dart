import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/exceptions.dart';
import '../models/task_model.dart';
import '../../domain/entities/task.dart'; // Needed for TaskStatus enum maybe? No, derived from model.

abstract class TaskRemoteDataSource {
  Stream<List<TaskModel>> getTasks(String projectId);
  Stream<QuerySnapshot<Map<String, dynamic>>> getTaskSnapshots(
      String projectId);
  Future<TaskModel> createTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String taskId);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final FirebaseFirestore firestore;

  TaskRemoteDataSourceImpl(this.firestore);

  @override
  Stream<List<TaskModel>> getTasks(String projectId) {
    return firestore
        .collection('tasks')
        .where('projectId', isEqualTo: projectId)
        .orderBy('status') // Simple ordering
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => TaskModel.fromFirestore(doc)).toList());
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getTaskSnapshots(
      String projectId) {
    return firestore
        .collection('tasks')
        .where('projectId', isEqualTo: projectId)
        .orderBy('status')
        .snapshots();
  }

  @override
  Future<TaskModel> createTask(TaskModel task) async {
    try {
      final docRef =
          await firestore.collection('tasks').add(task.toFirestore());
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
          .collection('tasks')
          .doc(task.id)
          .update(task.toFirestore());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    try {
      await firestore.collection('tasks').doc(taskId).delete();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
