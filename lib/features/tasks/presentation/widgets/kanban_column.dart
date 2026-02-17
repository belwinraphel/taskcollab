import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';
import 'task_board_theme.dart';
import 'task_card.dart';

class KanbanColumn extends StatelessWidget {
  final String title;
  final TaskStatus status;
  final List<TaskEntity> tasks;
  final Function(TaskEntity) onTaskTap;

  const KanbanColumn({
    super.key,
    required this.title,
    required this.status,
    required this.tasks,
    required this.onTaskTap,
  });

  @override
  Widget build(BuildContext context) {
    final statusTasks = tasks.where((t) => t.status == status).toList();

    return Container(
      width: 320, // Fixed width for horizontal scrolling
      margin: const EdgeInsets.symmetric(horizontal: 12),
      // Use constrained constraints to avoid unbounded height errors if nested incorrectly
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: Column(
        children: [
          _buildHeader(statusTasks.length),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: statusTasks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return TaskCard(
                  task: statusTasks[index],
                  onTap: () => onTaskTap(statusTasks[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(int count) {
    return Row(
      children: [
        Text(
          '$title ($count)'.toUpperCase(),
          style: TaskBoardTheme.columnHeader,
        ),
        const Spacer(),
        // Simple dot indicator for status color
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: _getStatusColor(status),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.todo:
        return TaskBoardTheme.todoColor;
      case TaskStatus.inProgress:
        return TaskBoardTheme.inProgressColor;
     
      case TaskStatus.done:
        return TaskBoardTheme.doneColor;
    }
  }
}
