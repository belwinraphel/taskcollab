import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../auth/domain/entities/user.dart';
import '../repositories/profile_repository.dart';

class GetProfile implements UseCase<UserEntity, GetProfileParams> {
  final ProfileRepository repository;

  GetProfile(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(GetProfileParams params) async {
    return await repository.getProfile(params.userId);
  }
}

class GetProfileParams extends Equatable {
  final String userId;

  const GetProfileParams({required this.userId});

  @override
  List<Object> get props => [userId];
}
