import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> searchUsers(String query);
  Future<List<UserModel>> getUsersByIds(List<String> ids);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<UserModel>> searchUsers(String query) async {
    final lowerQuery = query.toLowerCase();

    // Search by email_lowercase
    final emailQuery = await firestore
        .collection('users')
        .orderBy('email_lowercase')
        .startAt([lowerQuery])
        .endAt([lowerQuery + '\uf8ff'])
        .limit(20)
        .get();

    final users =
        emailQuery.docs.map((doc) => UserModel.fromFirestore(doc)).toList();

    // If result count is low, could also search displayName, but let's stick to email for efficiency first
    // Or do a parallel query if strictly needed. For now email is primary unique identifier people search by.

    return users;
  }

  @override
  Future<List<UserModel>> getUsersByIds(List<String> ids) async {
    if (ids.isEmpty) return [];

    final List<UserModel> users = [];

    // Chunk into batches of 10
    for (var i = 0; i < ids.length; i += 10) {
      final end = (i + 10 < ids.length) ? i + 10 : ids.length;
      final batchIds = ids.sublist(i, end);

      final snapshot = await firestore
          .collection('users')
          .where(FieldPath.documentId, whereIn: batchIds)
          .get();

      users.addAll(snapshot.docs.map((doc) => UserModel.fromFirestore(doc)));
    }

    return users;
  }
}
