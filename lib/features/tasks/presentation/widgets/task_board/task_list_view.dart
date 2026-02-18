import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_collab_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:task_collab_app/features/users/presentation/bloc/users_state.dart';
import '../../../domain/entities/task.dart';
import '../kanban_task_card.dart';

class TaskListView extends StatelessWidget {
  final String title;
  final List<TaskEntity> tasks;
  final Function(TaskEntity) onTaskTap;

  const TaskListView({
    super.key,
    required this.title,
    required this.tasks,
    required this.onTaskTap,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        final users = state.maybeWhen(
          loaded: (users) => users,
          orElse: () => null,
        );

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return KanbanTaskCard(
              task: task,
              onTap: () => onTaskTap(task),
              users: users,
            );
          },
        );
      },
    );
  }
}
