import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> searchUsers(String query);
  Future<Either<Failure, List<UserEntity>>> getUsersByIds(List<String> ids);
  void clearCache();
}
