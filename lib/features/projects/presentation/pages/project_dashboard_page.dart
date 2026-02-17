import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';

import '../bloc/projects_bloc.dart';
import '../bloc/projects_event.dart';
import '../bloc/projects_state.dart';
import '../widgets/add_edit_project_dialog.dart';
import '../../../tasks/presentation/pages/task_board_page.dart';

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
            appBar: AppBar(
              title: const Text('Projects'),
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
              child: const Icon(Icons.add),
            ),
            body: BlocBuilder<ProjectsBloc, ProjectsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (message) => Center(child: Text('Error: $message')),
                  loaded: (projects) {
                    if (projects.isEmpty) {
                      return const Center(child: Text('No projects found.'));
                    }
                    return ListView.builder(
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        final project = projects[index];
                        return ListTile(
                          title: Text(project.name),
                          subtitle: Text(project.description),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  TaskBoardPage(projectId: project.id),
                            ));
                          },
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  final bloc = context.read<ProjectsBloc>();
                                  showDialog(
                                    context: context,
                                    builder: (context) => BlocProvider.value(
                                      value: bloc,
                                      child: AddEditProjectDialog(
                                          project: project),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  context.read<ProjectsBloc>().add(
                                        ProjectsEvent.deleteProject(project.id),
                                      );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
