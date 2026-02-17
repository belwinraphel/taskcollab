import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/create_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/update_task.dart';
import '../../domain/usecases/delete_task.dart';
import 'tasks_event.dart';
import 'tasks_state.dart';

import '../../../../core/services/task_notification_listener.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetTasks getTasks;
  final CreateTask createTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;
  final TaskNotificationListener taskNotificationListener;

  TasksBloc({
    required this.getTasks,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
    required this.taskNotificationListener,
  }) : super(const TasksState.initial()) {
    on<TasksStarted>(_onStarted);
    on<TasksCreateTask>(_onCreateTask);
    on<TasksUpdateTask>(_onUpdateTask);
    on<TasksDeleteTask>(_onDeleteTask);
    on<TasksFilterChanged>(_onFilterChanged);
  }

  @override
  Future<void> close() {
    taskNotificationListener.stopListening();
    return super.close();
  }

  Future<void> _onStarted(TasksStarted event, Emitter<TasksState> emit) async {
    emit(const TasksState.loading());
    taskNotificationListener.startListening(event.projectId);
    final result = await getTasks(GetTasksParams(projectId: event.projectId));
    await result.fold(
      (failure) async => emit(TasksState.error(failure.message)),
      (stream) async {
        await emit.forEach(
          stream,
          onData: (tasks) {
            var filter = TaskStatus.todo;
            if (state is TasksLoaded) {
              filter = (state as TasksLoaded).currentFilter;
            }
            return TasksState.loaded(tasks, currentFilter: filter);
          },
          onError: (e, s) => TasksState.error(e.toString()),
        );
      },
    );
  }

  Future<void> _onCreateTask(
      TasksCreateTask event, Emitter<TasksState> emit) async {
    // Optimistic update not needed as we rely on stream updates
    final result = await createTask(CreateTaskParams(task: event.task));
    result.fold(
      (failure) => emit(TasksState.error(failure.message)),
      (_) {}, // Success, stream will update
    );
  }

  Future<void> _onUpdateTask(
      TasksUpdateTask event, Emitter<TasksState> emit) async {
    final result = await updateTask(UpdateTaskParams(task: event.task));
    result.fold(
      (failure) => emit(TasksState.error(failure.message)),
      (_) {}, // Success
    );
  }

  Future<void> _onDeleteTask(
      TasksDeleteTask event, Emitter<TasksState> emit) async {
    final result = await deleteTask(
        DeleteTaskParams(projectId: event.projectId, taskId: event.taskId));
    result.fold(
      (failure) => emit(TasksState.error(failure.message)),
      (_) {}, // Success
    );
  }

  void _onFilterChanged(TasksFilterChanged event, Emitter<TasksState> emit) {
    if (state is TasksLoaded) {
      final currentState = state as TasksLoaded;
      emit(currentState.copyWith(currentFilter: event.filter));
    }
  }
}
