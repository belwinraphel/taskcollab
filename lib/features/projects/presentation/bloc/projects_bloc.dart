import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/create_project.dart';
import '../../domain/usecases/delete_project.dart';
import '../../domain/usecases/get_projects.dart';
import '../../domain/usecases/update_project.dart';
import 'projects_event.dart';
import 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final GetProjects getProjects;
  final CreateProject createProject;
  final UpdateProject updateProject;
  final DeleteProject deleteProject;

  ProjectsBloc({
    required this.getProjects,
    required this.createProject,
    required this.updateProject,
    required this.deleteProject,
  }) : super(const ProjectsState.initial()) {
    on<ProjectsStarted>(_onStarted);
    on<ProjectsCreateProject>(_onCreateProject);
    on<ProjectsUpdateProject>(_onUpdateProject);
    on<ProjectsDeleteProject>(_onDeleteProject);
  }

  Future<void> _onStarted(
      ProjectsStarted event, Emitter<ProjectsState> emit) async {
    emit(const ProjectsState.loading());
    final result = await getProjects(NoParams());
    await result.fold(
      (failure) async => emit(ProjectsState.error(failure.message)),
      (stream) async {
        await emit.forEach(
          stream,
          onData: (projects) => ProjectsState.loaded(projects),
          onError: (e, stackTrace) => ProjectsState.error(e.toString()),
        );
      },
    );
  }

  Future<void> _onCreateProject(
      ProjectsCreateProject event, Emitter<ProjectsState> emit) async {
    final result = await createProject(
        CreateProjectParams(name: event.name, description: event.description));
    result.fold(
      (failure) => emit(ProjectsState.error(failure.message)),
      (_) {
        // Success handled by stream
      },
    );
  }

  Future<void> _onUpdateProject(
      ProjectsUpdateProject event, Emitter<ProjectsState> emit) async {
    final result = await updateProject(event.project);
    result.fold(
      (failure) => emit(ProjectsState.error(failure.message)),
      (_) {
        // Success handled by stream
      },
    );
  }

  Future<void> _onDeleteProject(
      ProjectsDeleteProject event, Emitter<ProjectsState> emit) async {
    final result = await deleteProject(event.projectId);
    result.fold(
      (failure) => emit(ProjectsState.error(failure.message)),
      (_) {
        // Success handled by stream
      },
    );
  }
}
