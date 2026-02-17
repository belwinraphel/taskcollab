import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/entities/user.dart';
import '../bloc/users_bloc.dart';
import '../bloc/users_event.dart';
import '../bloc/users_state.dart';

class UserSearchDelegate extends SearchDelegate<UserEntity?> {
  final UsersBloc _usersBloc;

  UserSearchDelegate() : _usersBloc = getIt<UsersBloc>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _usersBloc.add(UsersEvent.searchUsers(query));

    return BlocProvider.value(
      value: _usersBloc,
      child: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text('Error: $message')),
            loaded: (users) {
              if (users.isEmpty) {
                return const Center(child: Text('No users found.'));
              }
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(user.displayName?[0].toUpperCase() ??
                          user.email[0].toUpperCase()),
                    ),
                    title: Text(user.displayName ?? 'No Name'),
                    subtitle: Text(user.email),
                    onTap: () {
                      close(context, user);
                    },
                  );
                },
              );
            },
            orElse: () =>
                const Center(child: Text('Start typing to search users...')),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text('Search by email or name'));
    }

    // Trigger search for suggestions too
    _usersBloc.add(UsersEvent.searchUsers(query));

    return BlocProvider.value(
      value: _usersBloc,
      child: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text('Error: $message')),
            loaded: (users) {
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(user.displayName ?? user.email),
                    subtitle: Text(user.email),
                    onTap: () {
                      close(context, user);
                    },
                  );
                },
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _usersBloc.close();
    super.dispose();
  }
}
