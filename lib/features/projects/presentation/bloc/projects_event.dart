import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/project.dart';

part 'projects_event.freezed.dart';

@freezed
class ProjectsEvent with _$ProjectsEvent {
  const factory ProjectsEvent.started() = ProjectsStarted;
  const factory ProjectsEvent.createProject(String name, String description) =
      ProjectsCreateProject;
  const factory ProjectsEvent.updateProject(Project project) =
      ProjectsUpdateProject;
  const factory ProjectsEvent.deleteProject(String projectId) =
      ProjectsDeleteProject;
  const factory ProjectsEvent.addMember(String projectId, String userId) =
      ProjectsAddMember;
}
