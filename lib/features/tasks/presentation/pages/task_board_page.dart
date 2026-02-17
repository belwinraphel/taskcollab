import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_collab_app/features/tasks/presentation/widgets/add_edit_task_dialog.dart';
import 'package:task_collab_app/features/users/presentation/bloc/users_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/entities/task.dart';
import '../bloc/tasks_bloc.dart';
import '../bloc/tasks_event.dart';
import '../bloc/tasks_state.dart';
import '../../../projects/presentation/bloc/projects_bloc.dart';
import '../../../projects/presentation/bloc/projects_event.dart';

import 'task_details_page.dart';

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
        body: BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            return state.map(
              initial: (_) => const Center(child: CircularProgressIndicator()),
              loading: (_) => const Center(child: CircularProgressIndicator()),
              loaded: (state) => _buildBoard(context, state.tasks),
              error: (state) => Center(child: Text('Error: ${state.message}')),
            );
          },
        ),
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

  Widget _buildBoard(BuildContext context, List<TaskEntity> tasks) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildColumn(context, 'To Do', TaskStatus.todo, tasks),
          _buildColumn(context, 'Active', TaskStatus.inProgress, tasks),
          _buildColumn(context, 'Done', TaskStatus.done, tasks),
        ],
      ),
    );
  }

  Widget _buildColumn(BuildContext context, String title, TaskStatus status,
      List<TaskEntity> allTasks) {
    final tasks = allTasks.where((t) => t.status == status).toList();
    return DragTarget<TaskEntity>(
      onWillAcceptWithDetails: (details) => details.data.status != status,
      onAcceptWithDetails: (details) {
        final task = details.data;
        final updatedTask = TaskEntity(
          id: task.id,
          projectId: task.projectId,
          title: task.title,
          description: task.description,
          status: status,
          priority: task.priority,
          dueDate: task.dueDate,
          assignees: task.assignees,
          comments: task.comments,
        );
        context.read<TasksBloc>().add(TasksEvent.updateTask(updatedTask));
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 300,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
            border: candidateData.isNotEmpty
                ? Border.all(color: Colors.blue, width: 2)
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              ...tasks.map((task) => _buildTaskCard(context, task)),
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTaskCard(BuildContext context, TaskEntity task) {
    return Draggable<TaskEntity>(
      data: task,
      feedback: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: 280,
          padding: const EdgeInsets.all(8.0),
          color: Colors.white,
          child: Text(task.title),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _taskCardWidget(context, task),
      ),
      child: _taskCardWidget(context, task),
    );
  }

  Widget _taskCardWidget(BuildContext context, TaskEntity task) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: context.read<TasksBloc>()),
                  BlocProvider.value(value: context.read<UsersBloc>()),
                  BlocProvider(
                      create: (_) => getIt<ProjectsBloc>()
                        ..add(const ProjectsEvent
                            .started())), // Create new & load for details
                ],
                child: TaskDetailsPage(task: task),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              if (task.description.isNotEmpty)
                Text(task.description,
                    maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}
