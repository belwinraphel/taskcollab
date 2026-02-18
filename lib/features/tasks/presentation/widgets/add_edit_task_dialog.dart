import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../../users/domain/repositories/user_repository.dart';
import '../../domain/entities/task.dart';
import '../bloc/tasks_bloc.dart';
import '../bloc/tasks_event.dart';
import '../bloc/task_form/task_form_cubit.dart';
import '../../../projects/presentation/bloc/projects_bloc.dart';
import '../../../projects/presentation/bloc/projects_state.dart';
import '../../../../core/utils/validators.dart';

class AddEditTaskDialog extends StatelessWidget {
  final String projectId;
  final TaskEntity? task;

  const AddEditTaskDialog({
    super.key,
    required this.projectId,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskFormCubit(
        task: task,
        userRepository: getIt<UserRepository>(),
      ),
      child: _AddEditTaskDialogContent(
        projectId: projectId,
        task: task,
      ),
    );
  }
}

class _AddEditTaskDialogContent extends StatefulWidget {
  final String projectId;
  final TaskEntity? task;

  const _AddEditTaskDialogContent({
    required this.projectId,
    this.task,
  });

  @override
  State<_AddEditTaskDialogContent> createState() =>
      _AddEditTaskDialogContentState();
}

class _AddEditTaskDialogContentState extends State<_AddEditTaskDialogContent> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descController;

  List<String>? _lastMemberIds;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descController =
        TextEditingController(text: widget.task?.description ?? '');
    _fetchProjectMembers();
  }

  void _fetchProjectMembers() {
    final projectsState = context.read<ProjectsBloc>().state;
    if (projectsState is ProjectsLoaded) {
      try {
        final project = projectsState.projects.firstWhere(
          (p) => p.id == widget.projectId,
        );

        // Optimization: prevent redundant fetches
        final currentMemberIds = project.memberIds;
        if (_lastMemberIds != null &&
            _lastMemberIds!.length == currentMemberIds.length &&
            _lastMemberIds!.toSet().containsAll(currentMemberIds)) {
          return;
        }
        _lastMemberIds = List.from(currentMemberIds);

        context.read<TaskFormCubit>().loadProjectMembers(
              widget.projectId,
              additionalIds: project.memberIds,
            );
      } catch (_) {
        // Project might not be in the loaded list if filtering etc.
        // Still try to load assignees if present (handled inside loadProjectMembers)
        context.read<TaskFormCubit>().loadProjectMembers(widget.projectId);
      }
    } else {
      context.read<TaskFormCubit>().loadProjectMembers(widget.projectId);
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
    return BlocListener<ProjectsBloc, ProjectsState>(
      listener: (context, state) {
        if (state is ProjectsLoaded) {
          _fetchProjectMembers();
        }
      },
      child: AlertDialog(
        title: Text(widget.task != null ? 'Edit Task' : 'Create Task'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleField(),
                const SizedBox(height: 8),
                _buildDescriptionField(),
                const SizedBox(height: 16),
                _buildPriorityDropdown(),
                const SizedBox(height: 16),
                _buildAssigneeSelector(),
                const SizedBox(height: 16),
                _buildDatePicker(),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildTitleField() {
    return BlocBuilder<TaskFormCubit, TaskFormState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(labelText: 'Title'),
          validator: Validators.required,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) =>
              context.read<TaskFormCubit>().titleChanged(value),
        );
      },
    );
  }

  Widget _buildDescriptionField() {
    return BlocBuilder<TaskFormCubit, TaskFormState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextFormField(
          controller: _descController,
          decoration: const InputDecoration(labelText: 'Description'),
          maxLines: 3,
          onChanged: (value) =>
              context.read<TaskFormCubit>().descriptionChanged(value),
        );
      },
    );
  }

  Widget _buildPriorityDropdown() {
    return BlocBuilder<TaskFormCubit, TaskFormState>(
      buildWhen: (previous, current) => previous.priority != current.priority,
      builder: (context, state) {
        return DropdownButtonFormField<TaskPriority>(
          value: state.priority,
          decoration: const InputDecoration(labelText: 'Priority'),
          items: TaskPriority.values.map((priority) {
            return DropdownMenuItem(
              value: priority,
              child: Text(priority.name.toUpperCase()),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              context.read<TaskFormCubit>().priorityChanged(value);
            }
          },
        );
      },
    );
  }

  Widget _buildAssigneeSelector() {
    return BlocBuilder<TaskFormCubit, TaskFormState>(
      buildWhen: (previous, current) =>
          previous.availableMembers != current.availableMembers ||
          previous.assignees != current.assignees,
      builder: (context, state) {
        if (state.availableMembers.isEmpty) {
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
              children: state.availableMembers.map((user) {
                final isSelected = state.assignees.any((u) => u.id == user.id);
                return FilterChip(
                  label: Text(user.displayName ?? user.email),
                  avatar: user.photoUrl != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(user.photoUrl!),
                        )
                      : null,
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      context.read<TaskFormCubit>().addAssignee(user);
                    } else {
                      context.read<TaskFormCubit>().removeAssignee(user);
                    }
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
    return BlocBuilder<TaskFormCubit, TaskFormState>(
      buildWhen: (previous, current) => previous.dueDate != current.dueDate,
      builder: (context, state) {
        final date = state.dueDate ?? DateTime.now();
        return Row(
          children: [
            const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  context.read<TaskFormCubit>().dueDateChanged(picked);
                }
              },
              child: Text(
                "${date.day}/${date.month}/${date.year}",
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSaveButton() {
    return BlocBuilder<TaskFormCubit, TaskFormState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () => _saveTask(context, state),
          child: Text(widget.task != null ? 'Save' : 'Create'),
        );
      },
    );
  }

  void _saveTask(BuildContext context, TaskFormState state) {
    if (!_formKey.currentState!.validate()) return;
    if (!state.isValid) return;

    final assignees = state.assignees
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
        title: state.title.trim(),
        description: state.description.trim(),
        status: widget.task!.status,
        priority: state.priority,
        assignees: assignees,
        dueDate: state.dueDate,
        comments: widget.task!.comments,
      );
      context.read<TasksBloc>().add(TasksEvent.updateTask(updatedTask));
    } else {
      final newTask = TaskEntity(
        id: '',
        projectId: widget.projectId,
        title: state.title.trim(),
        description: state.description.trim(),
        status: TaskStatus.todo,
        priority: state.priority,
        assignees: assignees,
        dueDate: state.dueDate,
        comments: const [],
      );
      context.read<TasksBloc>().add(TasksEvent.createTask(newTask));
    }
    Navigator.pop(context);
  }
}
