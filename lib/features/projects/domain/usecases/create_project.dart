import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/project.dart';
import '../repositories/project_repository.dart';

class CreateProject implements UseCase<Project, CreateProjectParams> {
  final ProjectRepository repository;

  CreateProject(this.repository);

  @override
  Future<Either<Failure, Project>> call(CreateProjectParams params) async {
    return await repository.createProject(params.name, params.description);
  }
}

class CreateProjectParams extends Equatable {
  final String name;
  final String description;

  const CreateProjectParams({required this.name, required this.description});

  @override
  List<Object> get props => [name, description];
}
