import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/entities/task.dart';
import '../bloc/tasks_bloc.dart';
import '../bloc/tasks_event.dart';
import '../bloc/tasks_state.dart';
import '../widgets/add_edit_task_dialog.dart';
import '../widgets/task_board/kanban_board_view.dart';
import 'package:task_collab_app/core/utils/constants.dart';

import '../../../projects/presentation/bloc/projects_bloc.dart';
import '../../../users/presentation/bloc/users_bloc.dart';
import 'task_details_page.dart';
import '../widgets/task_board_header.dart';
import '../widgets/task_list_view.dart';
import '../widgets/add_member_dialog.dart';

class ProjectTaskBoardPage extends StatefulWidget {
  final String projectId;
  final String? projectName;

  const ProjectTaskBoardPage({
    super.key,
    required this.projectId,
    this.projectName,
  });

  @override
  State<ProjectTaskBoardPage> createState() => _ProjectTaskBoardPageState();
}

class _ProjectTaskBoardPageState extends State<ProjectTaskBoardPage> {
  late TasksBloc _tasksBloc;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tasksBloc = getIt<TasksBloc>()..add(TasksEvent.started(widget.projectId));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _tasksBloc),
        BlocProvider(create: (_) => getIt<UsersBloc>()),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: TaskBoardHeader(
                projectId: widget.projectId,
                projectName: widget.projectName,
                onAddMemberCheck: () => _showAddMemberDialog(context),
              ),
            ),
            backgroundColor: KanbanConstants.statusTodo,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showAddEditTaskDialog(context),
              child: const Icon(Icons.add),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<TasksBloc, TasksState>(
                      builder: (context, state) {
                        return state.maybeMap(
                          initial: (_) =>
                              const Center(child: CircularProgressIndicator()),
                          loading: (_) =>
                              const Center(child: CircularProgressIndicator()),
                          error: (state) =>
                              Center(child: Text('Error: ${state.message}')),
                          loaded: (state) {
                            if (_currentIndex == 0) {
                              return Center(
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 800),
                                  child: TaskListView(
                                    state: state,
                                    onTaskTap: (task) =>
                                        _navigateToTaskDetails(context, task),
                                    onTaskStatusUpdate: (task, status) =>
                                        _updateTaskStatus(
                                            context, task, status),
                                  ),
                                ),
                              );
                            } else {
                              return _buildKanbanView(context, state);
                            }
                          },
                          orElse: () => const SizedBox.shrink(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'List View',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.view_kanban),
                  label: 'Board View',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildKanbanView(BuildContext context, TasksLoaded state) {
    return KanbanBoardView(
      tasks: state.tasks,
      onTaskTap: (task) => _navigateToTaskDetails(context, task),
    );
  }

  void _navigateToTaskDetails(BuildContext context, TaskEntity task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: context.read<ProjectsBloc>(),
            ),
            BlocProvider.value(
              value: _tasksBloc,
            ),
            BlocProvider.value(
              value: context.read<UsersBloc>(),
            ),
          ],
          child: TaskDetailsPage(task: task),
        ),
      ),
    );
  }

  void _updateTaskStatus(
      BuildContext context, TaskEntity task, TaskStatus newStatus) {
    if (task.status == newStatus) return;
    final updatedTask = TaskEntity(
      id: task.id,
      projectId: task.projectId,
      title: task.title,
      description: task.description,
      status: newStatus,
      priority: task.priority,
      dueDate: task.dueDate,
      assignees: task.assignees,
      comments: task.comments,
    );
    context.read<TasksBloc>().add(TasksEvent.updateTask(updatedTask));
  }

  void _showAddEditTaskDialog(BuildContext context, {TaskEntity? task}) {
    showDialog(
      context: context,
      builder: (ctx) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<ProjectsBloc>()),
          BlocProvider.value(value: context.read<TasksBloc>()),
        ],
        child: AddEditTaskDialog(
          projectId: widget.projectId,
          task: task,
        ),
      ),
    );
  }

  void _showAddMemberDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<ProjectsBloc>()),
          BlocProvider.value(value: context.read<UsersBloc>()),
        ],
        child: AddMemberDialog(
          projectId: widget.projectId,
        ),
      ),
    );
  }
}
