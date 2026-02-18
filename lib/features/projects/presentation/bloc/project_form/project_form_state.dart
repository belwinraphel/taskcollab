import 'package:equatable/equatable.dart';
import '../../../../users/domain/entities/user.dart';
import '../../../domain/entities/project.dart';

enum ProjectFormStatus { initial, valid, invalid }

class ProjectFormState extends Equatable {
  final String name;
  final String description;
  final List<UserEntity> members;
  final ProjectFormStatus status;
  final bool isEditing;
  final Project? initialProject;

  const ProjectFormState({
    this.name = '',
    this.description = '',
    this.members = const [],
    this.status = ProjectFormStatus.initial,
    this.isEditing = false,
    this.initialProject,
  });

  bool get isValid => name.trim().isNotEmpty;

  ProjectFormState copyWith({
    String? name,
    String? description,
    List<UserEntity>? members,
    ProjectFormStatus? status,
    bool? isEditing,
    Project? initialProject,
  }) {
    return ProjectFormState(
      name: name ?? this.name,
      description: description ?? this.description,
      members: members ?? this.members,
      status: status ?? this.status,
      isEditing: isEditing ?? this.isEditing,
      initialProject: initialProject ?? this.initialProject,
    );
  }

  @override
  List<Object?> get props =>
      [name, description, members, status, isEditing, initialProject];
}
