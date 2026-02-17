import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final Map<String, UserEntity> _userCache = {};

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<UserEntity>>> searchUsers(String query) async {
    try {
      final users = await remoteDataSource.searchUsers(query);
      // Cache results? Maybe not necessary for search results as they change often based on query.
      // But we can cache individual users found.
      for (var user in users) {
        _userCache[user.id] = user;
      }
      return Right(users);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsersByIds(
      List<String> ids) async {
    try {
      final List<UserEntity> result = [];
      final List<String> missingIds = [];

      // Check cache first
      for (var id in ids) {
        if (_userCache.containsKey(id)) {
          result.add(_userCache[id]!);
        } else {
          missingIds.add(id);
        }
      }

      // Fetch missing from remote
      if (missingIds.isNotEmpty) {
        final remoteUsers = await remoteDataSource.getUsersByIds(missingIds);
        for (var user in remoteUsers) {
          _userCache[user.id] = user;
          result.add(user);
        }
      }

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  void clearCache() {
    _userCache.clear();
  }
}
