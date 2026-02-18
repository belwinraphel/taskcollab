import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/user.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserEntity>> getProfile(String userId);
  Future<Either<Failure, UserEntity>> updateProfile(UserEntity user);
}
