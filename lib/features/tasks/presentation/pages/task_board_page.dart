import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/entities/task.dart';
import '../bloc/tasks_bloc.dart';
import '../bloc/tasks_event.dart';
import '../bloc/tasks_state.dart';

class TaskBoardPage extends StatelessWidget {
  final String projectId;

  const TaskBoardPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<TasksBloc>()..add(TasksEvent.started(projectId)),
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
              onPressed: () => _showCreateTaskDialog(context, projectId),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildColumn(context, 'To Do', TaskStatus.todo, tasks),
          _buildColumn(context, 'In Progress', TaskStatus.inProgress, tasks),
          _buildColumn(context, 'Done', TaskStatus.done, tasks),
        ],
      ),
    );
  }

  Widget _buildColumn(BuildContext context, String title, TaskStatus status,
      List<TaskEntity> allTasks) {
    final tasks = allTasks.where((t) => t.status == status).toList();
    return DragTarget<TaskEntity>(
      onWillAccept: (task) => task != null && task.status != status,
      onAccept: (task) {
        final updatedTask = TaskEntity(
          id: task.id,
          projectId: task.projectId,
          title: task.title,
          description: task.description,
          status: status,
          priority: task.priority,
          dueDate: task.dueDate,
          assigneeId: task.assigneeId,
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
              ...tasks.map((task) => _buildTaskCard(task)),
              const SizedBox(height: 50), // Drop area padding
            ],
          ),
        );
      },
    );
  }

  Widget _buildTaskCard(TaskEntity task) {
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
        child: _taskCardWidget(task),
      ),
      child: _taskCardWidget(task),
    );
  }

  Widget _taskCardWidget(TaskEntity task) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
    );
  }

  void _showCreateTaskDialog(BuildContext context, String projectId) {
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
              // Need a real user ID here. For now validation will happen in repo/usecase or skipped
              // Assuming repo handles defaults or we pass empty and backend handles it
              final newTask = TaskEntity(
                id: '', // Generated by backend
                projectId: projectId,
                title: titleController.text,
                description: descController.text,
                status: TaskStatus.todo,
                priority: TaskPriority.medium,
                assigneeId: '', // Current user
              );
              context.read<TasksBloc>().add(TasksEvent.createTask(newTask));
              Navigator.pop(ctx);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
