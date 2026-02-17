import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:task_collab_app/features/auth/data/models/user_model.dart';
 import '../../../../core/error/exceptions.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getLastUser();
  Future<void> clearCache();
}

const cachedUserKey = 'CACHED_USER';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl(this.secureStorage);

  @override
  Future<void> cacheUser(UserModel user) async {
    final jsonString = json.encode(user.toJson());
    await secureStorage.write(key: cachedUserKey, value: jsonString);
  }

  @override
  Future<UserModel?> getLastUser() async {
    final jsonString = await secureStorage.read(key: cachedUserKey);
    if (jsonString != null) {
      try {
        return UserModel.fromJson(json.decode(jsonString));
      } catch (e) {
        throw CacheException();
      }
    } else {
      return null;
    }
  }

  @override
  Future<void> clearCache() async {
    await secureStorage.delete(key: cachedUserKey);
  }
}
