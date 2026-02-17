import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';

import 'package:intl/intl.dart';
import 'dart:math';

class KanbanTaskCard extends StatelessWidget {
  final TaskEntity task;
  final VoidCallback onTap;

  const KanbanTaskCard({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<TaskEntity>(
      data: task,
      feedback: SizedBox(
        width: 300,
        child: Opacity(
          opacity: 0.8,
          child: Material(
            color: Colors.transparent,
            child: _buildCardContent(context),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildCardContent(context),
      ),
      child: _buildCardContent(context),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Colored Indicator Bar
              Container(
                width: 6,
                decoration: BoxDecoration(
                  color: _getStatusColor(task.status),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1D1D1D),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Description
                      Text(
                        task.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF757575),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Footer (Avatars + Time)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: _buildAvatars()),
                          _buildTimeTag(task.dueDate),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.todo:
        return Colors.blue;
      case TaskStatus.inProgress:
        return Colors.green; // Active

      case TaskStatus.done:
        return Colors.purple;
    }
  }

  Widget _buildAvatars() {
    if (task.assignees.isEmpty) {
      return _buildAvatar('UN', Colors.grey.withOpacity(0.2), Colors.grey);
    }

    return SizedBox(
      height: 28,
      width: 28.0 + (task.assignees.length - 1) * 18.0,
      child: Stack(
        children: [
          for (int i = 0; i < task.assignees.length && i < 3; i++)
            Positioned(
              left: i * 18.0,
              child: _buildAssigneeAvatar(task.assignees[i]),
            ),
          if (task.assignees.length > 3)
            Positioned(
              left: 3 * 18.0,
              child: _buildRemainingCount(task.assignees.length - 3),
            ),
        ],
      ),
    );
  }

  Widget _buildAssigneeAvatar(TaskAssignee assignee) {
    if (assignee.avatarUrl != null) {
      return CircleAvatar(
        radius: 14,
        backgroundImage: NetworkImage(assignee.avatarUrl!),
      );
    }
    final initials = (assignee.name?.isNotEmpty == true)
        ? assignee.name![0].toUpperCase()
        : '?';
    final color = _generateColor(assignee.id);
    return _buildAvatar(initials, color.withOpacity(0.2), color);
  }

  Widget _buildRemainingCount(int count) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Center(
        child: Text(
          '+$count',
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
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

  Widget _buildTimeTag(DateTime? date) {
    if (date == null) return const SizedBox();
    final formattedDate = DateFormat('MMM d').format(date);

    return Row(
      children: [
        const Icon(Icons.access_time, size: 14, color: Color(0xFF9CA3AF)),
        const SizedBox(width: 4),
        Text(
          formattedDate,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF9CA3AF),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Color _generateColor(String id) {
    final hash = id.hashCode;
    final r = (hash & 0xFF0000) >> 16;
    final g = (hash & 0x00FF00) >> 8;
    final b = (hash & 0x0000FF);
    return Color.fromARGB(255, r, g, b);
  }
}
