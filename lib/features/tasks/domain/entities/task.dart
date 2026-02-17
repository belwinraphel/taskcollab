import 'package:equatable/equatable.dart';

enum TaskStatus { todo, inProgress, done }

enum TaskPriority { low, medium, high }

class TaskEntity extends Equatable {
  final String id;
  final String projectId;
  final String title;
  final String description;
  final TaskStatus status;
  final TaskPriority priority;
  final DateTime? dueDate;
  final List<TaskAssignee> assignees;
  final List<String> comments;

  const TaskEntity({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    this.dueDate,
    this.assignees = const [],
    this.comments = const [],
  });

  @override
  List<Object?> get props => [
        id,
        projectId,
        title,
        description,
        status,
        priority,
        dueDate,
        assignees,
        comments
      ];
}

class TaskAssignee extends Equatable {
  final String id;
  final String? name; // display name or email
  final String? avatarUrl;

  const TaskAssignee({
    required this.id,
    this.name,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, name, avatarUrl];
}
