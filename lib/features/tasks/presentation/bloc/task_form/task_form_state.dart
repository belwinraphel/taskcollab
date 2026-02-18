import 'package:equatable/equatable.dart';
import '../../../../users/domain/entities/user.dart';
import '../../../domain/entities/task.dart';

class TaskFormState extends Equatable {
  final String title;
  final String description;
  final List<UserEntity> assignees;
  final List<UserEntity> availableMembers;
  final DateTime? dueDate;
  final TaskPriority priority;
  final bool isEditing;
  final bool isSubmitting;
  final String? errorMessage;
  final bool isSuccess;

  // Validation
  bool get isValid => title.trim().isNotEmpty;

  const TaskFormState({
    this.title = '',
    this.description = '',
    this.assignees = const [],
    this.availableMembers = const [],
    this.dueDate,
    this.priority = TaskPriority.medium,
    this.isEditing = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  TaskFormState copyWith({
    String? title,
    String? description,
    List<UserEntity>? assignees,
    List<UserEntity>? availableMembers,
    DateTime? dueDate,
    TaskPriority? priority,
    bool? isEditing,
    bool? isSubmitting,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return TaskFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      assignees: assignees ?? this.assignees,
      availableMembers: availableMembers ?? this.availableMembers,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isEditing: isEditing ?? this.isEditing,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage:
          errorMessage, // Nullable override logic if needed, but for copyWith usually we pass null to clear? No, copyWith keeps old if null passed. But we might want to clear error.
      // Simplification: Let's assume passed null means "keep existing". To clear, we need a specific mechanism or just re-create state.
      // For error message, usually we clear it on new actions.
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        assignees,
        availableMembers,
        dueDate,
        priority,
        isEditing,
        isSubmitting,
        errorMessage,
        isSuccess,
      ];
}
