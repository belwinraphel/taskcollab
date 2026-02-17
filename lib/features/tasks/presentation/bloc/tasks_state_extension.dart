import '../../domain/entities/task.dart';
import 'tasks_state.dart';

extension TasksLoadedX on TasksLoaded {
  List<TaskEntity> get filteredTasks =>
      tasks.where((t) => t.status == currentFilter).toList();

  int get todoCount => tasks.where((t) => t.status == TaskStatus.todo).length;
  int get inProgressCount =>
      tasks.where((t) => t.status == TaskStatus.inProgress).length;
  int get doneCount => tasks.where((t) => t.status == TaskStatus.done).length;
}
