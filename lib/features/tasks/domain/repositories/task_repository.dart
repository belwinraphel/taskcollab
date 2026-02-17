import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, Stream<List<TaskEntity>>>> getTasks(String projectId);
  Future<Either<Failure, TaskEntity>> createTask(TaskEntity task);
  Future<Either<Failure, void>> updateTask(TaskEntity task);
  Future<Either<Failure, void>> deleteTask(String projectId, String taskId);
}
