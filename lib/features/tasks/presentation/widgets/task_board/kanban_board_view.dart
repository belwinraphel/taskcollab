import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_collab_app/features/tasks/domain/entities/task.dart';
import 'package:task_collab_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:task_collab_app/features/tasks/presentation/bloc/tasks_event.dart';
import '../kanban_column.dart';
import '../../bloc/kanban_board/kanban_board_cubit.dart';
import '../../bloc/kanban_board/kanban_board_state.dart';

class KanbanBoardView extends StatelessWidget {
  final List<TaskEntity> tasks;
  final Function(TaskEntity) onTaskTap;

  const KanbanBoardView({
    super.key,
    required this.tasks,
    required this.onTaskTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KanbanBoardCubit(),
      child: _KanbanBoardContent(
        tasks: tasks,
        onTaskTap: onTaskTap,

      ),
    );
  }
}

class _KanbanBoardContent extends StatefulWidget {
  final List<TaskEntity> tasks;
  final Function(TaskEntity) onTaskTap;

  const _KanbanBoardContent({
    required this.tasks,
    required this.onTaskTap,
  });

  @override
  State<_KanbanBoardContent> createState() => _KanbanBoardContentState();
}

class _KanbanBoardContentState extends State<_KanbanBoardContent> {
  final TransformationController _transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();
     
    final initialState = context.read<KanbanBoardCubit>().state;
    _transformationController.value = initialState.matrix;
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _onInteractionUpdate(ScaleUpdateDetails details) {
    final maxScale = _transformationController.value.getMaxScaleOnAxis();
    context.read<KanbanBoardCubit>().onInteractionUpdate(
          maxScale,
          _transformationController.value,
        );
  }

  @override
  Widget build(BuildContext context) {
    final todoTasks =
        widget.tasks.where((t) => t.status == TaskStatus.todo).toList();
    final inProgressTasks =
        widget.tasks.where((t) => t.status == TaskStatus.inProgress).toList();
    final doneTasks =
        widget.tasks.where((t) => t.status == TaskStatus.done).toList();

 
    final columns = [
      RepaintBoundary(
        child: KanbanColumn(
          title: 'To Do',
          status: TaskStatus.todo,
          tasks: todoTasks,
          onTaskTap: widget.onTaskTap,
          onTaskDropped: (task) =>
              _updateTaskStatus(context, task, TaskStatus.todo),
        ),
      ),
      RepaintBoundary(
        child: KanbanColumn(
          title: 'In Progress',
          status: TaskStatus.inProgress,
          tasks: inProgressTasks,
          onTaskTap: widget.onTaskTap,
          onTaskDropped: (task) =>
              _updateTaskStatus(context, task, TaskStatus.inProgress),
        ),
      ),
      RepaintBoundary(
        child: KanbanColumn(
          title: 'Done',
          status: TaskStatus.done,
          tasks: doneTasks,
          onTaskTap: widget.onTaskTap,
          onTaskDropped: (task) =>
              _updateTaskStatus(context, task, TaskStatus.done),
        ),
      ),
        RepaintBoundary(
        child: KanbanColumn(
          title: 'Testing',
          status: TaskStatus.done,
          tasks: doneTasks,
          onTaskTap: widget.onTaskTap,
          onTaskDropped: (task) =>
              _updateTaskStatus(context, task, TaskStatus.done),
        ),
      ),
    ];

    return BlocListener<KanbanBoardCubit, KanbanBoardState>(
      listenWhen: (previous, current) => previous.matrix != current.matrix,
      listener: (context, state) {
        if (_transformationController.value != state.matrix) {
          _transformationController.value = state.matrix;
        }
      },
      child: Stack(
        children: [
          // The Board
          InteractiveViewer(
            transformationController: _transformationController,
            minScale: 0.5,
            maxScale: 2.0,
            constrained: false, // Infinite canvas for scrolling
            boundaryMargin: const EdgeInsets.all(double.infinity),
            onInteractionUpdate: _onInteractionUpdate,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: columns,
              ),
            ),
          ),

          // Zoom Controls Overlay (Bottom Right)
          Positioned(
            bottom: 24,
            left: 24,
            child: BlocBuilder<KanbanBoardCubit, KanbanBoardState>(
              buildWhen: (previous, current) => previous.scale != current.scale,
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildZoomControl(
                      icon: Icons.refresh,
                      onTap: () => context.read<KanbanBoardCubit>().resetZoom(),
                      tooltip: 'Reset Zoom',
                    ),
                    const SizedBox(height: 8),
                    _buildZoomControl(
                      icon: Icons.add,
                      onTap: () => context.read<KanbanBoardCubit>().zoomIn(),
                      tooltip: 'Zoom In',
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${(state.scale * 100).toInt()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildZoomControl(
                      icon: Icons.remove,
                      onTap: () => context.read<KanbanBoardCubit>().zoomOut(),
                      tooltip: 'Zoom Out',
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildZoomControl({
    required IconData icon,
    required VoidCallback onTap,
    required String tooltip,
  }) {
    return Material(
      color: Colors.white,
      elevation: 4,
      shape: const CircleBorder(),
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(icon, color: Colors.blueGrey, size: 20),
          ),
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
}
