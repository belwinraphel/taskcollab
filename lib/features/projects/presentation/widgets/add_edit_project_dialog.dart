import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.project?.description ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
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
                  memberIds: widget.project!.memberIds,
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
