import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_collab_app/features/tasks/domain/entities/task.dart';
import '../bloc/tasks_bloc.dart';
import '../bloc/tasks_event.dart';

import '../../../users/presentation/bloc/users_bloc.dart';
import '../../../users/presentation/bloc/users_event.dart';
import '../../../users/presentation/bloc/users_state.dart';
import '../../../users/domain/entities/user.dart';
import '../../../projects/presentation/bloc/projects_bloc.dart';
import '../../../projects/presentation/bloc/projects_state.dart';

class CreateTaskDialog extends StatefulWidget {
  final String projectId;

  const CreateTaskDialog({super.key, required this.projectId});

  @override
  State<CreateTaskDialog> createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends State<CreateTaskDialog> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  UserEntity? _selectedAssignee;
  DateTime _dueDate = DateTime.now().add(const Duration(days: 7));

  @override
  void initState() {
    super.initState();
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
      title: const Text('Create Task'),
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
          onPressed: _createTask,
          child: const Text('Create'),
        ),
      ],
    );
  }

  Widget _buildAssigneeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Assignee',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 8),
        BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            final users = state.maybeWhen(
              loaded: (users) => users,
              orElse: () => <UserEntity>[],
            );

            return InputDecorator(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<UserEntity>(
                  value: _selectedAssignee,
                  hint: const Text('Select Assignee'),
                  isExpanded: true,
                  onChanged: (UserEntity? newValue) {
                    setState(() {
                      _selectedAssignee = newValue;
                    });
                  },
                  items: [
                    const DropdownMenuItem<UserEntity>(
                      value: null,
                      child: Text('Unassigned'),
                    ),
                    ...users.map((user) {
                      return DropdownMenuItem<UserEntity>(
                        value: user,
                        child: Row(
                          children: [
                            if (user.photoUrl != null)
                              CircleAvatar(
                                radius: 10,
                                backgroundImage: NetworkImage(user.photoUrl!),
                              )
                            else
                              const Icon(Icons.person, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                user.displayName ?? user.email,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ],
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

  void _createTask() {
    if (_titleController.text.isEmpty) return;

    final newTask = TaskEntity(
      id: '',
      projectId: widget.projectId,
      title: _titleController.text,
      description: _descController.text,
      status: TaskStatus.todo,
      priority: TaskPriority.medium,
      assignees: _selectedAssignee != null
          ? [
              TaskAssignee(
                id: _selectedAssignee!.id,
                name:
                    _selectedAssignee!.displayName ?? _selectedAssignee!.email,
                avatarUrl: _selectedAssignee!.photoUrl,
              )
            ]
          : [],
      dueDate: _dueDate,
      comments: const [],
    );

    context.read<TasksBloc>().add(TasksEvent.createTask(newTask));
    Navigator.pop(context);
  }
}
