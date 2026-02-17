import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';

class TaskDetailsPage extends StatelessWidget {
  final TaskEntity task;

  const TaskDetailsPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Description'),
            Text(task.description.isNotEmpty
                ? task.description
                : 'No description provided.'),
            const SizedBox(height: 16),
            _buildSectionTitle('Status'),
            Text(task.status.name.toUpperCase()),
            const SizedBox(height: 16),
            _buildSectionTitle('Priority'),
            Text(task.priority.name.toUpperCase()),
            const SizedBox(height: 16),
            if (task.dueDate != null) ...[
              _buildSectionTitle('Due Date'),
              Text(task.dueDate!.toLocal().toString().split(' ')[0]),
              const SizedBox(height: 16),
            ],
            _buildSectionTitle('Assignee'),
            Text(task.assigneeId.isNotEmpty ? task.assigneeId : 'Unassigned'),
            const SizedBox(height: 16),
            _buildSectionTitle('Comments'),
            if (task.comments.isEmpty)
              const Text('No comments yet.')
            else
              ...task.comments.map((comment) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text('• $comment'),
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
