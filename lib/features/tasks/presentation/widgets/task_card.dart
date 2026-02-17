import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';
import 'task_board_theme.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor:
          const Color.fromRGBO(0, 0, 0, 0.2), // Adjusted for visibility
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: TaskBoardTheme.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildPriorityTag(task.priority),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                task.description,
                style: const TextStyle(
                  fontSize: 13,
                  color: TaskBoardTheme.textSecondary,
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildAssignees(task.assigneeId), // Placeholder for assignees
                  if (task.dueDate != null) _buildTimeTag(task.dueDate!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityTag(TaskPriority priority) {
    Color bg;
    Color text;
    String label;

    switch (priority) {
      case TaskPriority.high:
        bg = const Color(0xFFEFF6FF); // Light Blue
        text = const Color(0xFF3B82F6); // Blue
        label = 'High';
        break;
      case TaskPriority.medium:
        bg = const Color(0xFFF3F4F6); // Gray
        text = const Color(0xFF6B7280); // Gray text
        label = 'Med';
        break;
      case TaskPriority.low:
        bg = const Color(0xFFECFDF5); // Green
        text = const Color(0xFF10B981); // Green text
        label = 'Low';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: text,
        ),
      ),
    );
  }

  Widget _buildAssignees(String assigneeId) {
    // Mock avatars for now based on assigneeId (or random if empty)
    return Row(
      children: [
        _buildAvatar('JE', Colors.purple[100]!, Colors.purple),
        const SizedBox(width: -8),
        _buildAvatar('AS', Colors.blue[100]!, Colors.blue),
      ],
    );
  }

  Widget _buildAvatar(String initials, Color bg, Color text) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: text,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeTag(DateTime date) {
    // Formatting time manually or using intl if available. Minimal for now.
    final timeStr = "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    return Row(
      children: [
        Icon(Icons.access_time_filled, size: 14, color: Colors.grey[400]),
        const SizedBox(width: 4),
        Text(
          timeStr,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
