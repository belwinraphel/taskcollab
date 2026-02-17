import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/project.dart';

part 'projects_state.freezed.dart';

@freezed
class ProjectsState with _$ProjectsState {
  const factory ProjectsState.initial() = ProjectsInitial;
  const factory ProjectsState.loading() = ProjectsLoading;
  const factory ProjectsState.loaded(List<Project> projects) = ProjectsLoaded;
  const factory ProjectsState.error(String message) = ProjectsError;
}
