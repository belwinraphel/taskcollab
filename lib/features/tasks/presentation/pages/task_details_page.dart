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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Implement edit
            },
          ),
        ],
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
            _buildSectionTitle('Assignees'),
            if (task.assignees.isNotEmpty)
              ...task.assignees.map((assignee) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        if (assignee.avatarUrl != null)
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(assignee.avatarUrl!),
                          )
                        else
                          CircleAvatar(
                            radius: 12,
                            child: Text(
                              (assignee.name?.isNotEmpty == true)
                                  ? assignee.name![0].toUpperCase()
                                  : '?',
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        const SizedBox(width: 8),
                        Text(
                          assignee.name ?? assignee.id,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ))
            else
              const Text('Unassigned'),
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
