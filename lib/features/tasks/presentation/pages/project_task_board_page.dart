import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_collab_app/core/utils/helper.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/entities/task.dart';
import '../bloc/tasks_bloc.dart';
import '../bloc/tasks_event.dart';
import '../bloc/tasks_state.dart';
import '../widgets/kanban_task_card.dart';
import '../widgets/overview_summary_card.dart';

import '../bloc/tasks_state_extension.dart';
import '../../../projects/presentation/bloc/projects_bloc.dart';
import '../../../projects/presentation/bloc/projects_event.dart';
import '../../../users/presentation/bloc/users_bloc.dart';
import '../../../users/presentation/bloc/users_event.dart';
import '../../../users/presentation/bloc/users_state.dart';
import 'task_details_page.dart';

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

  @override
  void initState() {
    super.initState();
    _tasksBloc = getIt<TasksBloc>()..add(TasksEvent.started(widget.projectId));
  }

  @override
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
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showCreateTaskDialog(context),
              child: const Icon(Icons.add),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  _buildHeader(context),
                  Expanded(
                    child: BlocBuilder<TasksBloc, TasksState>(
                      builder: (context, state) {
                        return state.map(
                          initial: (_) =>
                              const Center(child: CircularProgressIndicator()),
                          loading: (_) =>
                              const Center(child: CircularProgressIndicator()),
                          error: (state) =>
                              Center(child: Text('Error: ${state.message}')),
                          loaded: (state) => _buildContent(context, state),
                        );
                      },
                    ),
                  ),
                  _buildBottomBar(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.blue),
                onPressed: () => Navigator.pop(context),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "${getShortProjectId(widget.projectId)} - ",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D1D1D),
                          ),
                        ),
                        TextSpan(
                          text: widget.projectName ?? 'Project',
                          style: const TextStyle(
                            overflow: TextOverflow.clip,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D1D1D),
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "PHASE HA1 - FIRST AC IMPLEMENTATION",
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9CA3AF),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.person_add, color: Colors.blue),
            onPressed: () => _showAddMemberDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, TasksLoaded state) {
    final filteredTasks = state.filteredTasks;
    final currentFilter = state.currentFilter;
    final todoCount = state.todoCount;
    final inProgressCount = state.inProgressCount;
    final doneCount = state.doneCount;

    return Row(
      children: [
        // Left Column: Active Tasks List
        Expanded(
          flex: 2, // Takes up more space
          child: Container(
            color: const Color(0xFFF9FAFB),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _getListTitle(currentFilter),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9CA3AF),
                        letterSpacing: 1.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDBEAFE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        filteredTasks.length.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    key: ValueKey(currentFilter),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      return KanbanTaskCard(
                        key: ValueKey(filteredTasks[index].id),
                        task: filteredTasks[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TaskDetailsPage(task: filteredTasks[index]),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right Column: Overview (Summary Cards)
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
                top: 16, left: 16), // No right padding, cards handle it
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    "OVERVIEW",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9CA3AF),
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                OverviewSummaryCard(
                  title: "TO DO",
                  count: todoCount,
                  statusColor: Colors.blue,
                  isSelected: currentFilter == TaskStatus.todo,
                  onTap: () {
                    context
                        .read<TasksBloc>()
                        .add(const TasksEvent.filterChanged(TaskStatus.todo));
                  },
                  onTaskDropped: (task) {
                    _updateTaskStatus(context, task, TaskStatus.todo);
                  },
                ),
                OverviewSummaryCard(
                  title: "ACTIVE",
                  // Mapping 'High Priority' tasks or InProgress to Active
                  count: inProgressCount,
                  statusColor: Colors.green,
                  isSelected: currentFilter == TaskStatus.inProgress,
                  onTap: () {
                    context.read<TasksBloc>().add(
                        const TasksEvent.filterChanged(TaskStatus.inProgress));
                  },
                  onTaskDropped: (task) {
                    _updateTaskStatus(context, task, TaskStatus.inProgress);
                  },
                ),
                OverviewSummaryCard(
                  title: "DONE",
                  count: doneCount,
                  statusColor: Colors.purple, // Using purple for done/history
                  isSelected: currentFilter == TaskStatus.done,
                  onTap: () {
                    context
                        .read<TasksBloc>()
                        .add(const TasksEvent.filterChanged(TaskStatus.done));
                  },
                  onTaskDropped: (task) {
                    _updateTaskStatus(context, task, TaskStatus.done);
                  },
                ),
                const Spacer(),
                const Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.add, color: Color(0xFFD1D5DB)),
                  ),
                ),
                const SizedBox(height: 8),
                const Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.search, color: Color(0xFFD1D5DB)),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    // Mock bottom bar matching design
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFFF4F5F9), // Light bg
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBottomTab("Eng", false),
          _buildBottomTab("GS", false),
          const SizedBox(width: 8),
          _buildPagination(),
          const SizedBox(width: 8),
          _buildBottomTab("HA1", true),
          _buildBottomTab("HA2", false),
        ],
      ),
    );
  }

  Widget _buildBottomTab(String title, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.blue : const Color(0xFF9CA3AF),
          ),
        ),
        const SizedBox(height: 4),
        if (isSelected)
          Container(
            width: 20,
            height: 2,
            color: Colors.blue,
          ),
      ],
    );
  }

  Widget _buildPagination() {
    return Row(
      children: [
        for (int i = 1; i <= 3; i++) // Showing few pages
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(i == 3 ? "3" : "$i", // Mock selection of page 3
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        i == 3 ? Colors.blue : Colors.blue.withOpacity(0.5))),
          ),
      ],
    );
  }

  String _getListTitle(TaskStatus status) {
    switch (status) {
      case TaskStatus.todo:
        return "TO DO TASKS";
      case TaskStatus.inProgress:
        return "ACTIVE TASKS";

      default:
        return "DONE TASKS";
    }
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
      assigneeId: task.assigneeId,
      comments: task.comments,
    );
    context.read<TasksBloc>().add(TasksEvent.updateTask(updatedTask));
  }

  void _showCreateTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title')),
            TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description')),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              final newTask = TaskEntity(
                id: '',
                projectId: widget.projectId,
                title: titleController.text,
                description: descController.text,
                status: TaskStatus.todo,
                priority: TaskPriority.medium,
                assigneeId: '',
                dueDate: DateTime.now().add(const Duration(days: 7)),
                comments: const [],
              );
              _tasksBloc.add(TasksEvent.createTask(newTask));
              Navigator.pop(ctx);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showAddMemberDialog(BuildContext context) {
    final searchController = TextEditingController();
    final usersBloc = context.read<UsersBloc>();
    // ProjectsBloc is passed from the previous page via BlocProvider.value
    final projectsBloc = context.read<ProjectsBloc>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Member'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: searchController,
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
                  bloc: usersBloc,
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
                                            ? (user.displayName ??
                                                user.email)[0]
                                            : '?')
                                        .toUpperCase())
                                    : null,
                              ),
                              title: Text(user.displayName ?? user.email),
                              subtitle: Text(user.email),
                              onTap: () {
                                projectsBloc.add(ProjectsEvent.addMember(
                                    widget.projectId, user.id));
                                Navigator.pop(ctx);
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
              Navigator.pop(ctx);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
