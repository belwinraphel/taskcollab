import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> login(
      String email, String password) async {
    try {
      final userModel = await remoteDataSource.login(email, password);
      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(
      String email, String password) async {
    try {
      final userModel = await remoteDataSource.register(email, password);
      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<UserEntity?> get authUserStream async* {
    // 1. Yield cached user immediately for fast startup (Offline-First)
    try {
      final cachedUser = await localDataSource.getLastUser();
      if (cachedUser != null) yield cachedUser;
    } catch (_) {
      // Ignore cache errors, proceed to remote
    }

    // 2. Yield from Firebase Stream with deduplication
    yield* remoteDataSource.authUserStream
        .distinct((prev, next) => prev?.id == next?.id)
        .map((userModel) {
      if (userModel != null) {
        localDataSource.cacheUser(userModel);
        return userModel;
      } else {
        localDataSource.clearCache();
        return null;
      }
    });
  }

  @override
  Future<Either<Failure, void>> updateFcmToken(String token) async {
    try {
      await remoteDataSource.updateFcmToken(token);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
