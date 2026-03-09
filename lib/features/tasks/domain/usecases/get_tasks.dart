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
    return await repository.getTasks(params.projectId, limit: params.limit);
  }
}

class GetTasksParams extends Equatable {
  final String projectId;
  final int limit;

  const GetTasksParams({required this.projectId, this.limit = 100});

  @override
  List<Object> get props => [projectId, limit];
}
