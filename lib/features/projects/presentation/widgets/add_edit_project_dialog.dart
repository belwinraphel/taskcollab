import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../features/users/domain/entities/user.dart';
import '../../../../features/users/presentation/bloc/users_bloc.dart';
import '../../../../features/users/presentation/bloc/users_event.dart';
import '../../../../features/users/presentation/bloc/users_state.dart';
import '../../../../features/users/presentation/delegates/user_search_delegate.dart';
import '../../domain/entities/project.dart';
import '../bloc/projects_bloc.dart';
import '../bloc/projects_event.dart';
import '../bloc/project_form/project_form_cubit.dart';

class AddEditProjectDialog extends StatelessWidget {
  final Project? project;

  const AddEditProjectDialog({super.key, this.project});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProjectFormCubit(project: project),
        ),
        BlocProvider(
          create: (_) => getIt<UsersBloc>(),
        ),
      ],
      child: _AddEditProjectDialogContent(project: project),
    );
  }
}

class _AddEditProjectDialogContent extends StatefulWidget {
  final Project? project;

  const _AddEditProjectDialogContent({this.project});

  @override
  State<_AddEditProjectDialogContent> createState() =>
      _AddEditProjectDialogContentState();
}

class _AddEditProjectDialogContentState
    extends State<_AddEditProjectDialogContent> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.project?.description ?? '');

    // If editing, fetch existing members to populate the list
    if (widget.project != null && widget.project!.memberIds.isNotEmpty) {
      context
          .read<UsersBloc>()
          .add(UsersEvent.getUsersByIds(widget.project!.memberIds));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to UsersBloc to populate ProjectFormCubit members on load
    return MultiBlocListener(
      listeners: [
        BlocListener<UsersBloc, UsersState>(
          listener: (context, state) {
            state.mapOrNull(
              loaded: (loadedState) {
                // Populate the form cubit with loaded members
                context.read<ProjectFormCubit>().setMembers(loadedState.users);
              },
            );
          },
        ),
      ],
      child: AlertDialog(
        title: Text(widget.project != null ? 'Edit Project' : 'New Project'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildNameField(),
                const SizedBox(height: 16),
                _buildDescriptionField(),
                const SizedBox(height: 16),
                if (widget.project != null) ...[
                  _buildMembersSection(context),
                ],
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          _buildSaveButton(context),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return BlocBuilder<ProjectFormCubit, ProjectFormState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Project Name',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) =>
              context.read<ProjectFormCubit>().nameChanged(value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildDescriptionField() {
    return BlocBuilder<ProjectFormCubit, ProjectFormState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextFormField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          onChanged: (value) =>
              context.read<ProjectFormCubit>().descriptionChanged(value),
        );
      },
    );
  }

  Widget _buildMembersSection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Members',
                style: TextStyle(fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: () async {
                final UserEntity? selectedUser = await showSearch<UserEntity?>(
                  context: context,
                  delegate: UserSearchDelegate(),
                );
                if (selectedUser != null && context.mounted) {
                  context.read<ProjectFormCubit>().addMember(selectedUser);
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildMembersList(),
      ],
    );
  }

  Widget _buildMembersList() {
    return BlocBuilder<ProjectFormCubit, ProjectFormState>(
      buildWhen: (previous, current) => previous.members != current.members,
      builder: (context, state) {
        return Container(
          height: 150,
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: state.members.isEmpty
              ? const Center(child: Text('No members yet'))
              : ListView.builder(
                  itemCount: state.members.length,
                  itemBuilder: (context, index) {
                    final member = state.members[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(member.email[0].toUpperCase()),
                      ),
                      title: Text(member.displayName ?? member.email),
                      subtitle: Text(member.email),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          context.read<ProjectFormCubit>().removeMember(member);
                        },
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return BlocBuilder<ProjectFormCubit, ProjectFormState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.isValid
              ? () {
                  if (state.isEditing) {
                    final updatedProject = Project(
                      id: widget.project!.id,
                      name: state.name,
                      description: state.description,
                      ownerId: widget.project!.ownerId,
                      memberIds: state.members.map((e) => e.id).toList(),
                      createdAt: widget.project!.createdAt,
                    );
                    context.read<ProjectsBloc>().add(
                          ProjectsEvent.updateProject(updatedProject),
                        );
                  } else {
                    context.read<ProjectsBloc>().add(
                          ProjectsEvent.createProject(
                            state.name,
                            state.description,
                          ),
                        );
                  }
                  Navigator.pop(context);
                }
              : null,
          child: Text(widget.project != null ? 'Save' : 'Create'),
        );
      },
    );
  }
}
