import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/project_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class ProjectRemoteDataSource {
  Stream<List<ProjectModel>> getProjects();
  Future<ProjectModel> createProject(
      String name, String description, String ownerId);
  Future<void> updateProject(ProjectModel project);
  Future<void> deleteProject(String projectId);
}

class ProjectRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final FirebaseFirestore firestore;

  ProjectRemoteDataSourceImpl(this.firestore);

  @override
  Stream<List<ProjectModel>> getProjects() {
    return firestore
        .collection('projects')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ProjectModel.fromFirestore(doc))
            .toList());
  }

  @override
  Future<ProjectModel> createProject(
      String name, String description, String ownerId) async {
    try {
      final docRef = await firestore.collection('projects').add({
        'name': name,
        'description': description,
        'ownerId': ownerId,
        'memberIds': [ownerId],
        'createdAt': FieldValue.serverTimestamp(),
      });
      final doc = await docRef.get();
      return ProjectModel.fromFirestore(doc);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateProject(ProjectModel project) async {
    try {
      await firestore
          .collection('projects')
          .doc(project.id)
          .update(project.toFirestore());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteProject(String projectId) async {
    try {
      await firestore.collection('projects').doc(projectId).delete();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
