import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_collab_app/core/di/injection_container.dart';
import 'package:task_collab_app/features/tasks/domain/entities/task.dart';
import 'package:task_collab_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:task_collab_app/features/tasks/presentation/bloc/tasks_state.dart';
import 'package:task_collab_app/features/tasks/presentation/pages/task_details_page.dart';

import '../../../../users/presentation/bloc/users_bloc.dart';
import '../../../../users/presentation/bloc/users_event.dart';
import '../../../../projects/presentation/bloc/projects_bloc.dart';
import '../../../../projects/presentation/bloc/projects_event.dart';
import 'task_board_header.dart';
import 'task_list_view.dart';

class TaskBoardBody extends StatefulWidget {
  final String projectId;

  const TaskBoardBody({super.key, required this.projectId});

  @override
  State<TaskBoardBody> createState() => _TaskBoardBodyState();
}

class _TaskBoardBodyState extends State<TaskBoardBody> {
  final TaskStatus _selectedStatus = TaskStatus.inProgress; // Default to Active

  @override
  void initState() {
    super.initState();
    _fetchProjectMembers();
  }

  void _fetchProjectMembers() {
    final projectsState = context.read<ProjectsBloc>().state;
    projectsState.maybeWhen(
      loaded: (projects) {
        try {
          final project = projects.firstWhere((p) => p.id == widget.projectId);
          if (project.memberIds.isNotEmpty) {
            context
                .read<UsersBloc>()
                .add(UsersEvent.getUsersByIds(project.memberIds));
          }
        } catch (_) {}
      },
      orElse: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom Header
        TaskBoardHeader(projectId: widget.projectId),
        Expanded(
          child: BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              return state.map(
                initial: (_) =>
                    const Center(child: CircularProgressIndicator()),
                loading: (_) =>
                    const Center(child: CircularProgressIndicator()),
                error: (state) =>
                    Center(child: Text('Error: ${state.message}')),
                loaded: (state) {
                  final tasks = state.tasks;
                  final filteredTasks =
                      tasks.where((t) => t.status == _selectedStatus).toList();

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Main Task List Area
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Expanded(
                              child: TaskListView(
                                title: _getStatusTitle(_selectedStatus),
                                tasks: filteredTasks,
                                onTaskTap: (task) =>
                                    _navigateToTaskDetails(context, task),
                              ),
                            ),
                            // Bottom Pagination / Sections (Mock)
                            _buildBottomPagination(),
                          ],
                        ),
                      ),
                      // Right Sidebar Summary
                      // Expanded(
                      //   flex: 1,
                      //   child: TaskSummarySidebar(
                      //     counts: {
                      //       TaskStatus.todo: todoCount,
                      //       TaskStatus.inProgress: activeCount,
                      //       TaskStatus.done: doneCount,
                      //     },
                      //     selectedStatus: _selectedStatus,
                      //     onStatusSelected: (status) {
                      //       setState(() {
                      //         _selectedStatus = status;
                      //       });
                      //     },
                      //     onAddPressed: () => _showAddTaskDialog(context),
                      //   ),
                      // ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  String _getStatusTitle(TaskStatus status) {
    switch (status) {
      case TaskStatus.todo:
        return 'To Do Tasks';
      case TaskStatus.inProgress:
        return 'Active Tasks';
      case TaskStatus.done:
        return 'Completed Tasks';
    }
  }

  Widget _buildBottomPagination() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'SECTIONS',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9CA3AF),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(width: 16),
          _buildPageNumber(1, false),
          _buildPageNumber(2, false),
          _buildPageNumber(3, true), // Mock selected
          _buildPageNumber(4, false),
          _buildPageNumber(5, false),
        ],
      ),
    );
  }

  Widget _buildPageNumber(int number, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
          ),
        ),
      ),
    );
  }

  void _navigateToTaskDetails(BuildContext context, TaskEntity task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<TasksBloc>()),
            BlocProvider.value(value: context.read<UsersBloc>()),
            BlocProvider(
              create: (_) =>
                  getIt<ProjectsBloc>()..add(const ProjectsEvent.started()),
            ),
          ],
          child: TaskDetailsPage(task: task),
        ),
      ),
    );
  }
}
