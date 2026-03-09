import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';

class OverviewSummaryCard extends StatelessWidget {
  final String title;
  final int count;
  final Color statusColor;
  final bool isSelected;
  final VoidCallback onTap;
  final Function(TaskEntity)? onTaskDropped;

  const OverviewSummaryCard({
    super.key,
    required this.title,
    required this.count,
    required this.statusColor,
    this.isSelected = false,
    required this.onTap,
    this.onTaskDropped,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<TaskEntity>(
      onWillAcceptWithDetails: (details) =>
          true,  
      onAcceptWithDetails: (details) {
        if (onTaskDropped != null) {
          onTaskDropped!(details.data);
        }
      },
      builder: (context, candidateData, rejectedData) {
        final isHovering = candidateData.isNotEmpty;
        return Card(
          elevation: isSelected || isHovering ? 4 : 1,
          shadowColor: isSelected || isHovering
              ? statusColor.withValues(alpha: 0.4)
              : Colors.black12,
          margin: const EdgeInsets.only(bottom: 12, right: 16, left: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isSelected || isHovering
                ? BorderSide(color: statusColor, width: 2)
                : BorderSide.none,
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? statusColor : const Color(0xFF9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        count.toString(),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1D1D1D),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        "tasks",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
