import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_collab_app/features/tasks/domain/entities/task.dart';
import 'package:task_collab_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:task_collab_app/features/tasks/presentation/bloc/tasks_event.dart';
import '../kanban_column.dart';

class KanbanBoardView extends StatefulWidget {
  final List<TaskEntity> tasks;
  final Function(TaskEntity) onTaskTap;

  const KanbanBoardView({
    super.key,
    required this.tasks,
    required this.onTaskTap,
  });

  @override
  State<KanbanBoardView> createState() => _KanbanBoardViewState();
}

class _KanbanBoardViewState extends State<KanbanBoardView> {
  final TransformationController _transformationController =
      TransformationController();
  double _currentScale = 0.5; // Start zoomed out at 70%

  @override
  void initState() {
    super.initState();
    // Apply initial scale of 0.7
    _transformationController.value = Matrix4.identity()..scale(_currentScale);
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _onInteractionUpdate(ScaleUpdateDetails details) {
    setState(() {
      _currentScale = _transformationController.value.getMaxScaleOnAxis();
    });
  }

  void _zoomIn() {
    setState(() {
      _currentScale = (_currentScale + 0.1).clamp(0.5, 2.0);
      _updateTransformationController();
    });
  }

  void _zoomOut() {
    setState(() {
      _currentScale = (_currentScale - 0.1).clamp(0.5, 2.0);
      _updateTransformationController();
    });
  }

  void _resetZoom() {
    setState(() {
      _currentScale = 1.0;
      _transformationController.value = Matrix4.identity();
    });
  }

  void _updateTransformationController() {
    // Keep the current translation but update the scale
    final currentMatrix = _transformationController.value;
    final translation = currentMatrix.getTranslation();

    _transformationController.value = Matrix4.identity()
      ..translate(translation.x, translation.y)
      ..scale(_currentScale);
  }

  @override
  Widget build(BuildContext context) {
    final todoTasks =
        widget.tasks.where((t) => t.status == TaskStatus.todo).toList();
    final inProgressTasks =
        widget.tasks.where((t) => t.status == TaskStatus.inProgress).toList();
    final doneTasks =
        widget.tasks.where((t) => t.status == TaskStatus.done).toList();

    // Performance optimization: RepaintBoundary
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
    ];

    return Stack(
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildZoomControl(
                icon: Icons.refresh,
                onTap: _resetZoom,
                tooltip: 'Reset Zoom',
              ),
              const SizedBox(height: 8),
              _buildZoomControl(
                icon: Icons.add,
                onTap: _zoomIn,
                tooltip: 'Zoom In',
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${(_currentScale * 100).toInt()}%',
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
                onTap: _zoomOut,
                tooltip: 'Zoom Out',
              ),
            ],
          ),
        ),
      ],
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
