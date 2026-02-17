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

class AddEditProjectDialog extends StatefulWidget {
  final Project? project;

  const AddEditProjectDialog({super.key, this.project});

  @override
  State<AddEditProjectDialog> createState() => _AddEditProjectDialogState();
}

class _AddEditProjectDialogState extends State<AddEditProjectDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  final _usersBloc = getIt<UsersBloc>();
  List<UserEntity> _members = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.project?.description ?? '');

    if (widget.project != null && widget.project!.memberIds.isNotEmpty) {
      _usersBloc.add(UsersEvent.getUsersByIds(widget.project!.memberIds));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _usersBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.project != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Project' : 'New Project'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Project Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            if (isEditing) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Members',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.person_add),
                    onPressed: () async {
                      final UserEntity? selectedUser =
                          await showSearch<UserEntity?>(
                        context: context,
                        delegate: UserSearchDelegate(),
                      );
                      if (selectedUser != null) {
                        setState(() {
                          if (!_members.any((m) => m.id == selectedUser.id)) {
                            _members.add(selectedUser);
                          }
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              BlocProvider.value(
                value: _usersBloc,
                child: BlocListener<UsersBloc, UsersState>(
                  listener: (context, state) {
                    state.mapOrNull(
                      loaded: (loadedState) {
                        setState(() {
                          // Merge loaded users, avoiding duplicates if any logic conflict
                          // But mainly we want to initialize _members from this if it's the first load
                          // For simplicity, let's just add them if not present.
                          for (var user in loadedState.users) {
                            if (!_members.any((m) => m.id == user.id)) {
                              _members.add(user);
                            }
                          }
                        });
                      },
                    );
                  },
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: _members.isEmpty
                        ? const Center(child: Text('No members yet'))
                        : ListView.builder(
                            itemCount: _members.length,
                            itemBuilder: (context, index) {
                              final member = _members[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  child: Text(member.email[0].toUpperCase()),
                                ),
                                title: Text(member.displayName ?? member.email),
                                subtitle: Text(member.email),
                                trailing: IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    setState(() {
                                      _members.removeAt(index);
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (isEditing) {
                // Create a generic Project or copy the existing one with new values
                // Since Project is a domain entity, we might need a way to copyWith.
                // Assuming we can't easily modify the entity directly without copyWith or creating new.
                // The entity doesn't have copyWith in the file I saw, but I can create a new instance with same ID.

                // However, I need to know if Project has a copyWith method.
                // Looking at project.dart, it extends Equatable but doesn't show copyWith.
                // I'll create a new Project instance manually implicitly via the event handling or just pass the logic there.
                // Ideally I should update `Project` entity to have `copyWith`.

                // For now, I'll pass the updated fields to the Bloc?
                // No, the event expects a `Project` object.
                // So I will create a new Project object here inside the map.

                // Wait, I cannot instantiate `Project` if it was abstract, but it's a class.
                // I need the other fields (ownerId, memberIds, createdAt).
                // I should use the existing project's values for those.
                final updatedProject = Project(
                  id: widget.project!.id,
                  name: _nameController.text,
                  description: _descriptionController.text,
                  ownerId: widget.project!.ownerId,
                  memberIds: _members.map((e) => e.id).toList(),
                  createdAt: widget.project!.createdAt,
                );
                context.read<ProjectsBloc>().add(
                      ProjectsEvent.updateProject(updatedProject),
                    );
              } else {
                context.read<ProjectsBloc>().add(
                      ProjectsEvent.createProject(
                        _nameController.text,
                        _descriptionController.text,
                      ),
                    );
              }
              Navigator.pop(context);
            }
          },
          child: Text(isEditing ? 'Save' : 'Create'),
        ),
      ],
    );
  }
}
