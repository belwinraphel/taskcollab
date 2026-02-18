import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/domain/entities/user.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileLoadRequested(widget.userId));
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _enableEditing(UserEntity user) {
    setState(() {
      _isEditing = true;
      _nameController.text = user.displayName ?? '';
      _emailController.text = user.email;
    });
  }

  void _saveProfile(UserEntity user) {
    final updatedUser = UserEntity(
      id: user.id,
      email: user.email, // Email usually not editable here
      displayName: _nameController.text,
      photoUrl: user.photoUrl,
    );
    context.read<ProfileBloc>().add(ProfileUpdateRequested(updatedUser));
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              final state = context.read<ProfileBloc>().state;
              if (state is ProfileLoaded) {
                if (_isEditing) {
                  _saveProfile(state.user);
                } else {
                  _enableEditing(state.user);
                }
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is ProfileLoaded) {
            final user = state.user;
            if (!_isEditing) {
              _nameController.text = user.displayName ?? '';
              _emailController.text = user.email;
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: user.photoUrl != null
                        ? NetworkImage(user.photoUrl!)
                        : null,
                    child: user.photoUrl == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration:
                        const InputDecoration(labelText: 'Display Name'),
                    enabled: _isEditing,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    enabled: false, // Email not editable
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
