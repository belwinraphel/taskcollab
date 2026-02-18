import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/exceptions.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/entities/user.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getProfile(String userId);
  Future<UserModel> updateProfile(UserEntity user);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseFirestore firestore;

  ProfileRemoteDataSourceImpl(this.firestore);

  @override
  Future<UserModel> getProfile(String userId) async {
    try {
      final doc = await firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserModel.fromSnapshot(doc);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> updateProfile(UserEntity user) async {
    try {
      final userModel = UserModel(
        id: user.id,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoUrl,
      );

      await firestore
          .collection('users')
          .doc(user.id)
          .update(userModel.toJson());
      return userModel;
    } catch (e) {
      throw ServerException();
    }
  }
}
