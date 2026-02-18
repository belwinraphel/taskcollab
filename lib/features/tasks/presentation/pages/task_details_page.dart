import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_collab_app/features/projects/presentation/bloc/projects_bloc.dart';
import 'package:task_collab_app/features/projects/presentation/bloc/projects_event.dart';
import 'package:task_collab_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:task_collab_app/features/users/presentation/bloc/users_event.dart';
import 'package:task_collab_app/features/users/presentation/bloc/users_state.dart';
import 'package:task_collab_app/features/users/domain/entities/user.dart';
import '../../domain/entities/task.dart';
import '../bloc/tasks_bloc.dart';
import '../bloc/tasks_event.dart';
import '../bloc/tasks_state.dart';
import '../widgets/add_edit_task_dialog.dart';
import 'package:task_collab_app/core/utils/constants.dart';

import '../../../../core/di/injection_container.dart';

class TaskDetailsPage extends StatefulWidget {
  final TaskEntity task;

  const TaskDetailsPage({super.key, required this.task});

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch assignee details if needed
    if (widget.task.assignees.isNotEmpty) {
      final assigneeIds = widget.task.assignees.map((e) => e.id).toList();
      context.read<UsersBloc>().add(UsersEvent.getUsersByIds(assigneeIds));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksState>(
      listener: (context, state) {
        state.maybeMap(
          error: (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${e.message}')),
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        // Find the updated task in the list, or fallback to the initial task
        // If the task is deleted (not found), pop the page
        TaskEntity currentTask = widget.task;
        if (state is TasksLoaded) {
          try {
            currentTask = state.tasks.firstWhere((t) => t.id == widget.task.id);
          } catch (e) {
            // Task not found, possibly deleted. Pop the page.
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            });
            return const SizedBox.shrink();
          }
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _buildSliverAppBar(context, currentTask),
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStatusAndPriority(currentTask),
                          const SizedBox(height: 24),
                          _buildDescriptionSection(currentTask),
                          const SizedBox(height: 24),
                          _buildAssigneesSection(currentTask),
                          const SizedBox(height: 24),
                          _buildDateSection(currentTask),
                          const SizedBox(height: 24),
                          _buildCommentsSection(currentTask),
                          const SizedBox(height: 80), // Bottom padding for FAB
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showEditTaskDialog(context, currentTask),
            icon: const Icon(Icons.edit),
            label: const Text('Edit Task'),
          ),
        );
      },
    );
  }

  Widget _buildSliverAppBar(BuildContext context, TaskEntity task) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        title: Text(
          task.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade700,
                Colors.blue.shade900,
              ],
            ),
          ),
          child: Center(
            child: Icon(
              Icons.assignment,
              size: 80,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () => _confirmDelete(context, task),
        ),
      ],
    );
  }

  Widget _buildStatusAndPriority(TaskEntity task) {
    return Row(
      children: [
        _buildChip(
          label: task.status.name.toUpperCase(),
          color: _getStatusColor(task.status),
          icon: Icons.circle,
        ),
        const SizedBox(width: 12),
        _buildChip(
          label: task.priority.name.toUpperCase(),
          color: _getPriorityColor(task.priority),
          icon: Icons.flag,
        ),
      ],
    );
  }

  Widget _buildChip({
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(TaskEntity task) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: KanbanConstants.cardTitle,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(
            task.description.isNotEmpty
                ? task.description
                : 'No description provided.',
            style: const TextStyle(
              fontSize: 14,
              color: KanbanConstants.cardDescription,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAssigneesSection(TaskEntity task) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Assignees',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        if (task.assignees.isEmpty)
          const Text(
            'Unassigned',
            style: TextStyle(color: Colors.grey),
          )
        else
          BlocBuilder<UsersBloc, UsersState>(
            builder: (context, state) {
              final users = state.maybeWhen(
                loaded: (users) => users,
                orElse: () => [],
              );

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: task.assignees.map((assignee) {
                  UserEntity? user;
                  try {
                    user = users.firstWhere((u) => u.id == assignee.id);
                  } catch (_) {}

                  final displayName = user?.displayName ??
                      user?.email ??
                      assignee.name ??
                      assignee.id;
                  final avatarUrl = user?.photoUrl ?? assignee.avatarUrl;

                  return Chip(
                    avatar: avatarUrl != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(avatarUrl),
                          )
                        : CircleAvatar(
                            child: Text(
                              (displayName.isNotEmpty == true)
                                  ? displayName[0].toUpperCase()
                                  : '?',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                    label: Text(displayName),
                    backgroundColor: Colors.white,
                    elevation: 2,
                    shadowColor: Colors.black12,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  );
                }).toList(),
              );
            },
          ),
      ],
    );
  }

  Widget _buildDateSection(TaskEntity task) {
    if (task.dueDate == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Due Date',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.calendar_today, color: Colors.blueGrey),
            const SizedBox(width: 8),
            Text(
              DateFormat('MMMM d, yyyy').format(task.dueDate!),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCommentsSection(TaskEntity task) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Comments',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        if (task.comments.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'No comments yet.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        else
          ...task.comments.map((comment) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.comment, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          comment,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
      ],
    );
  }

  void _showEditTaskDialog(BuildContext context, TaskEntity task) {
    showDialog(
      context: context,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<TasksBloc>()),
          BlocProvider.value(value: context.read<UsersBloc>()),
          BlocProvider(
            create: (_) =>
                getIt<ProjectsBloc>()..add(const ProjectsEvent.started()),
          ),
        ],
        child: AddEditTaskDialog(
          projectId: task.projectId,
          task: task,
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, TaskEntity task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Dispatch delete event
              context.read<TasksBloc>().add(
                    TasksEvent.deleteTask(task.projectId, task.id),
                  );
              Navigator.pop(context); // Close dialog
              // Page pop is handled by BlocBuilder listener/builder when task not found
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.todo:
        return KanbanConstants.statusTodo;
      case TaskStatus.inProgress:
        return KanbanConstants.statusInProgress;
      case TaskStatus.done:
        return KanbanConstants.statusDone;
    }
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return KanbanConstants.priorityLow;
      case TaskPriority.medium:
        return KanbanConstants.priorityMedium;
      case TaskPriority.high:
        return KanbanConstants.priorityHigh;
    }
  }
}
