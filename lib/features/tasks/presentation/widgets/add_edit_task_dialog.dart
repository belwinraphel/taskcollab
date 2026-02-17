import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../bloc/tasks_bloc.dart';
import '../bloc/tasks_event.dart';

import '../../../users/presentation/bloc/users_bloc.dart';
import '../../../users/presentation/bloc/users_event.dart';
import '../../../users/presentation/bloc/users_state.dart';
import '../../../users/domain/entities/user.dart';
import '../../../projects/presentation/bloc/projects_bloc.dart';
import '../../../projects/presentation/bloc/projects_state.dart';

class AddEditTaskDialog extends StatefulWidget {
  final String projectId;
  final TaskEntity? task;

  const AddEditTaskDialog({
    super.key,
    required this.projectId,
    this.task,
  });

  @override
  State<AddEditTaskDialog> createState() => _AddEditTaskDialogState();
}

class _AddEditTaskDialogState extends State<AddEditTaskDialog> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final List<UserEntity> _selectedAssignees = [];
  DateTime _dueDate = DateTime.now().add(const Duration(days: 7));

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descController.text = widget.task!.description;
      if (widget.task!.dueDate != null) {
        _dueDate = widget.task!.dueDate!;
      }
      // We will map existing assignees to UserEntities once users are loaded
      // For now, we rely on _fetchProjectMembers to load users, and then we might need to match IDs
    }
    _fetchProjectMembers();
  }

  void _fetchProjectMembers() {
    final projectsState = context.read<ProjectsBloc>().state;
    if (projectsState is ProjectsLoaded) {
      final project = projectsState.projects.firstWhere(
        (p) => p.id == widget.projectId,
        orElse: () => throw Exception('Project not found'),
      );
      if (project.memberIds.isNotEmpty) {
        context
            .read<UsersBloc>()
            .add(UsersEvent.getUsersByIds(project.memberIds));
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task != null ? 'Edit Task' : 'Create Task'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            _buildAssigneeSelector(),
            const SizedBox(height: 16),
            _buildDatePicker(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveTask,
          child: Text(widget.task != null ? 'Save' : 'Create'),
        ),
      ],
    );
  }

  Widget _buildAssigneeSelector() {
    return BlocConsumer<UsersBloc, UsersState>(
      listener: (context, state) {
        state.whenOrNull(loaded: (users) {
          if (widget.task != null && _selectedAssignees.isEmpty) {
            // Restore selected assignees from task
            final assigneeIds = widget.task!.assignees.map((e) => e.id).toSet();
            setState(() {
              _selectedAssignees.addAll(
                users.where((u) => assigneeIds.contains(u.id)),
              );
            });
          }
        });
      },
      builder: (context, state) {
        final users = state.maybeWhen(
          loaded: (users) => users,
          orElse: () => <UserEntity>[],
        );

        if (users.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Assignees',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: users.map((user) {
                final isSelected =
                    _selectedAssignees.any((u) => u.id == user.id);
                return FilterChip(
                  label: Text(user.displayName ?? user.email),
                  avatar: user.photoUrl != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(user.photoUrl!),
                        )
                      : null,
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedAssignees.add(user);
                      } else {
                        _selectedAssignees.removeWhere((u) => u.id == user.id);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDatePicker() {
    return Row(
      children: [
        const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: _dueDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (picked != null) {
              setState(() => _dueDate = picked);
            }
          },
          child: Text(
            "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}",
          ),
        ),
      ],
    );
  }

  void _saveTask() {
    if (_titleController.text.isEmpty) return;

    final assignees = _selectedAssignees
        .map((u) => TaskAssignee(
              id: u.id,
              name: u.displayName ?? u.email,
              avatarUrl: u.photoUrl,
            ))
        .toList();

    if (widget.task != null) {
      final updatedTask = TaskEntity(
        id: widget.task!.id,
        projectId: widget.projectId,
        title: _titleController.text,
        description: _descController.text,
        status: widget.task!.status,
        priority: widget.task!.priority,
        assignees: assignees,
        dueDate: _dueDate,
        comments: widget.task!.comments,
      );
      context.read<TasksBloc>().add(TasksEvent.updateTask(updatedTask));
    } else {
      final newTask = TaskEntity(
        id: '',
        projectId: widget.projectId,
        title: _titleController.text,
        description: _descController.text,
        status: TaskStatus.todo,
        priority: TaskPriority.medium,
        assignees: assignees,
        dueDate: _dueDate,
        comments: const [],
      );
      context.read<TasksBloc>().add(TasksEvent.createTask(newTask));
    }
    Navigator.pop(context);
  }
}
