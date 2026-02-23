import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_collab_app/features/tasks/presentation/pages/project_task_board_page.dart';
import '../../../../core/di/injection_container.dart';

import '../bloc/projects_bloc.dart';
import '../bloc/projects_event.dart';
import '../bloc/projects_state.dart';
import '../widgets/add_edit_project_dialog.dart';
import '../widgets/project_grid_card.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

import '../../../profile/presentation/pages/settings_page.dart';
import '../../../notifications/presentation/pages/notifications_page.dart';
import '../../../../core/widgets/responsive_grid_builder.dart';

class ProjectDashboardPage extends StatelessWidget {
  const ProjectDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ProjectsBloc>()..add(const ProjectsEvent.started()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: const Color(0xFFF4F5F9), // Light background
            appBar: _buildAppBar(context),
            body: Column(
              children: [
                _buildSearchBar(),
                Expanded(
                  child: BlocBuilder<ProjectsBloc, ProjectsState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (message) =>
                            Center(child: Text('Error: $message')),
                        loaded: (projects) {
                          if (projects.isEmpty) {
                            return _buildEmptyState();
                          }
                          return Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 1200),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ResponsiveGridBuilder(
                                  itemCount: projects.length,
                                  columnThresholds: {
                                    600: 2,
                                    900: 3,
                                    1200: 4,
                                  },
                                  itemBuilder: (context, index) {
                                    final project = projects[index];
                                    return ProjectGridCard(
                                      project: project,
                                      onTap: () {
                                        final projectsBloc =
                                            context.read<ProjectsBloc>();
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (_) => BlocProvider.value(
                                            value: projectsBloc,
                                            child: ProjectTaskBoardPage(
                                              projectId: project.id,
                                              projectName: project.name,
                                            ),
                                          ),
                                        ));
                                      },
                                      onEdit: () {
                                        final bloc =
                                            context.read<ProjectsBloc>();
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              BlocProvider.value(
                                            value: bloc,
                                            child: AddEditProjectDialog(
                                                project: project),
                                          ),
                                        );
                                      },
                                      onDelete: () {
                                        context.read<ProjectsBloc>().add(
                                              ProjectsEvent.deleteProject(
                                                  project.id),
                                            );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        orElse: () => const SizedBox.shrink(),
                      );
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                final bloc = context.read<ProjectsBloc>();
                showDialog(
                  context: context,
                  builder: (context) => BlocProvider.value(
                    value: bloc,
                    child: const AddEditProjectDialog(),
                  ),
                );
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'My Projects',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.grey),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationsPage(),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            onTap: () {
              final authState = context.read<AuthBloc>().state;
              authState.maybeMap(
                authenticated: (state) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(userId: state.user.id),
                    ),
                  );
                },
                orElse: () {},
              );
            },
            child: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("U", style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search projects...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFFF3F4F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.grey),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_off_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No projects found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create a new project to get started',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
