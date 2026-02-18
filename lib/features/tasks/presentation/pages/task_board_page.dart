import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_collab_app/features/tasks/presentation/widgets/task_board/task_board_body.dart';
import 'package:task_collab_app/features/tasks/presentation/widgets/add_edit_task_dialog.dart';
import 'package:task_collab_app/features/users/presentation/bloc/users_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../bloc/tasks_bloc.dart';
import '../bloc/tasks_event.dart';
import '../../../projects/presentation/bloc/projects_bloc.dart';
import '../../../projects/presentation/bloc/projects_event.dart';

class TaskBoardPage extends StatelessWidget {
  final String projectId;

  const TaskBoardPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<TasksBloc>()..add(TasksEvent.started(projectId)),
        ),
        BlocProvider(
          create: (context) => getIt<UsersBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Task Board')),
        body: TaskBoardBody(projectId: projectId),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () => showDialog(
                context: context,
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: context.read<TasksBloc>()),
                    BlocProvider.value(value: context.read<UsersBloc>()),
                    // Provide ProjectsBloc for the dialog and load projects to find members
                    BlocProvider(
                        create: (_) => getIt<ProjectsBloc>()
                          ..add(const ProjectsEvent.started())),
                  ],
                  child: AddEditTaskDialog(projectId: projectId),
                ),
              ),
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}
