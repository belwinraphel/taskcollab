import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_collab_app/features/projects/presentation/bloc/projects_bloc.dart';
import 'package:task_collab_app/features/projects/presentation/bloc/projects_event.dart';
import 'package:task_collab_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:task_collab_app/features/users/presentation/bloc/users_event.dart';
import 'package:task_collab_app/features/users/presentation/bloc/users_state.dart';

class AddMemberDialog extends StatefulWidget {
  final String projectId;

  const AddMemberDialog({
    super.key,
    required this.projectId,
  });

  @override
  State<AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<AddMemberDialog> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usersBloc = context.read<UsersBloc>();

    return AlertDialog(
      title: const Text('Add Member'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Users',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                usersBloc.add(UsersEvent.searchUsers(query));
              },
            ),
            const SizedBox(height: 16),
            Flexible(
              child: BlocBuilder<UsersBloc, UsersState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (users) {
                      if (users.isEmpty) {
                        return const Text('No users found');
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: user.photoUrl != null
                                  ? NetworkImage(user.photoUrl!)
                                  : null,
                              child: user.photoUrl == null
                                  ? Text(((user.displayName ?? user.email)
                                              .isNotEmpty
                                          ? (user.displayName ?? user.email)[0]
                                          : '?')
                                      .toUpperCase())
                                  : null,
                            ),
                            title: Text(user.displayName ?? user.email),
                            subtitle: Text(user.email),
                            onTap: () {
                              context.read<ProjectsBloc>().add(
                                  ProjectsEvent.addMember(
                                      widget.projectId, user.id));
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Added ${user.displayName ?? user.email} to project')),
                              );
                            },
                          );
                        },
                      );
                    },
                    error: (message) => Text('Error: $message'),
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            usersBloc.add(const UsersEvent.clearCache());
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
