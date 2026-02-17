import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/task.dart';

part 'tasks_event.freezed.dart';

@freezed
class TasksEvent with _$TasksEvent {
  const factory TasksEvent.started(String projectId) = TasksStarted;
  const factory TasksEvent.createTask(TaskEntity task) = TasksCreateTask;
  const factory TasksEvent.updateTask(TaskEntity task) = TasksUpdateTask;
  const factory TasksEvent.deleteTask(String taskId) = TasksDeleteTask;
}
