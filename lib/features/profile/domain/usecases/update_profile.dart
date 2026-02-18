import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../auth/domain/entities/user.dart';
import '../repositories/profile_repository.dart';

class UpdateProfile implements UseCase<UserEntity, UpdateProfileParams> {
  final ProfileRepository repository;

  UpdateProfile(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(UpdateProfileParams params) async {
    return await repository.updateProfile(params.user);
  }
}

class UpdateProfileParams extends Equatable {
  final UserEntity user;

  const UpdateProfileParams({required this.user});

  @override
  List<Object> get props => [user];
}
