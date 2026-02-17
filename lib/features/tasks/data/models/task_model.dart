import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/task.dart';

class TaskModel extends TaskEntity {
  const TaskModel({
    required super.id,
    required super.projectId,
    required super.title,
    required super.description,
    required super.status,
    required super.priority,
    super.dueDate,
    super.assignees,
    super.comments,
  });

  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Handle legacy single assignee
    List<TaskAssignee> loadedAssignees = [];
    if (data['assignees'] != null) {
      loadedAssignees = (data['assignees'] as List)
          .map((e) => TaskAssignee(
                id: e['id'],
                name: e['name'],
                avatarUrl: e['avatarUrl'],
              ))
          .toList();
    } else if (data['assigneeId'] != null &&
        (data['assigneeId'] as String).isNotEmpty) {
      loadedAssignees.add(TaskAssignee(
        id: data['assigneeId'],
        name: data['assigneeName'],
        avatarUrl: data['assigneeAvatar'],
      ));
    }

    return TaskModel(
      id: doc.id,
      projectId: data['projectId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      status: TaskStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => TaskStatus.todo,
      ),
      priority: TaskPriority.values.firstWhere(
        (e) => e.name == data['priority'],
        orElse: () => TaskPriority.medium,
      ),
      dueDate: data['dueDate'] != null
          ? (data['dueDate'] as Timestamp).toDate()
          : null,
      assignees: loadedAssignees,
      comments: List<String>.from(data['comments'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'projectId': projectId,
      'title': title,
      'description': description,
      'status': status.name,
      'priority': priority.name,
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
      'assignees': assignees
          .map((e) => {
                'id': e.id,
                'name': e.name,
                'avatarUrl': e.avatarUrl,
              })
          .toList(),
      'comments': comments,
    };
  }
}
