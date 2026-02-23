import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetTasks implements UseCase<Stream<List<TaskEntity>>, GetTasksParams> {
  final TaskRepository repository;

  GetTasks(this.repository);

  @override
  Future<Either<Failure, Stream<List<TaskEntity>>>> call(
      GetTasksParams params) async {
    return await repository.getTasks(params.projectId);
  }
}

class GetTasksParams extends Equatable {
  final String projectId;

  const GetTasksParams({required this.projectId});

  @override
  List<Object> get props => [projectId];
}
