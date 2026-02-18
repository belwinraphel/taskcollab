import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_collab_app/core/utils/constants.dart';
import 'package:task_collab_app/features/tasks/domain/entities/task.dart';
import 'package:task_collab_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:task_collab_app/features/tasks/presentation/bloc/tasks_event.dart';
import 'package:task_collab_app/features/tasks/presentation/bloc/tasks_state.dart';
import 'package:task_collab_app/features/tasks/presentation/widgets/kanban_task_card.dart';
import 'package:task_collab_app/features/tasks/presentation/widgets/overview_summary_card.dart';
import 'package:task_collab_app/features/tasks/presentation/bloc/tasks_state_extension.dart';

class TaskListView extends StatelessWidget {
  final TasksLoaded state;
  final Function(TaskEntity) onTaskTap;
  final Function(TaskEntity, TaskStatus) onTaskStatusUpdate;

  const TaskListView({
    super.key,
    required this.state,
    required this.onTaskTap,
    required this.onTaskStatusUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final filteredTasks = state.filteredTasks;
    final currentFilter = state.currentFilter;
    final todoCount = state.todoCount;
    final inProgressCount = state.inProgressCount;
    final doneCount = state.doneCount;

    return Row(
      children: [
        // Left Column: Active Tasks List
        Expanded(
          flex: 2, // Takes up more space
          child: Container(
            color: KanbanConstants.listViewBackground,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _getListTitle(currentFilter),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: KanbanConstants.listTitleText,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: KanbanConstants.activeCountBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        filteredTasks.length.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: KanbanConstants.activeCountText,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    key: ValueKey(currentFilter),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      return KanbanTaskCard(
                        key: ValueKey(filteredTasks[index].id),
                        task: filteredTasks[index],
                        onTap: () => onTaskTap(filteredTasks[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right Column: Overview (Summary Cards)
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
                top: 16, left: 16), // No right padding, cards handle it
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    "OVERVIEW",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: KanbanConstants.overviewHeaderText,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                OverviewSummaryCard(
                  title: "TO DO",
                  count: todoCount,
                  statusColor: KanbanConstants.statusTodo,
                  isSelected: currentFilter == TaskStatus.todo,
                  onTap: () {
                    context
                        .read<TasksBloc>()
                        .add(const TasksEvent.filterChanged(TaskStatus.todo));
                  },
                  onTaskDropped: (task) {
                    onTaskStatusUpdate(task, TaskStatus.todo);
                  },
                ),
                OverviewSummaryCard(
                  title: "ACTIVE",
                  // Mapping 'High Priority' tasks or InProgress to Active
                  count: inProgressCount,
                  statusColor: KanbanConstants.statusInProgress,
                  isSelected: currentFilter == TaskStatus.inProgress,
                  onTap: () {
                    context.read<TasksBloc>().add(
                        const TasksEvent.filterChanged(TaskStatus.inProgress));
                  },
                  onTaskDropped: (task) {
                    onTaskStatusUpdate(task, TaskStatus.inProgress);
                  },
                ),
                OverviewSummaryCard(
                  title: "DONE",
                  count: doneCount,
                  statusColor: KanbanConstants
                      .statusDone, // Using purple for done/history
                  isSelected: currentFilter == TaskStatus.done,
                  onTap: () {
                    context
                        .read<TasksBloc>()
                        .add(const TasksEvent.filterChanged(TaskStatus.done));
                  },
                  onTaskDropped: (task) {
                    onTaskStatusUpdate(task, TaskStatus.done);
                  },
                ),
                const Spacer(),
                const Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.add, color: KanbanConstants.iconAdd),
                  ),
                ),
                const SizedBox(height: 8),
                const Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.search, color: KanbanConstants.iconSearch),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getListTitle(TaskStatus status) {
    switch (status) {
      case TaskStatus.todo:
        return "TO DO TASKS";
      case TaskStatus.inProgress:
        return "ACTIVE TASKS";

      default:
        return "DONE TASKS";
    }
  }
}
