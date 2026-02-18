import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../users/domain/repositories/user_repository.dart';
import '../../../../users/domain/entities/user.dart';
import '../../../domain/entities/project.dart';
import 'project_form_state.dart';
export 'project_form_state.dart';

class ProjectFormCubit extends Cubit<ProjectFormState> {
  final UserRepository userRepository;

  ProjectFormCubit({Project? project, required this.userRepository})
      : super(ProjectFormState(
          name: project?.name ?? '',
          description: project?.description ?? '',
          isEditing: project != null,
          initialProject: project,
        ));

  Future<void> loadMembers(List<String> ids) async {
    if (ids.isEmpty) return;

    final result = await userRepository.getUsersByIds(ids);
    result.fold(
      (failure) {
        // Optionally handle error
      },
      (users) {
        if (users.isNotEmpty) {
          emit(state.copyWith(members: users));
        }
      },
    );
  }

  void nameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  void descriptionChanged(String value) {
    emit(state.copyWith(description: value));
  }

  void addMember(UserEntity user) {
    if (!state.members.any((m) => m.id == user.id)) {
      emit(state.copyWith(members: List.from(state.members)..add(user)));
    }
  }

  void removeMember(UserEntity user) {
    emit(state.copyWith(
      members: state.members.where((m) => m.id != user.id).toList(),
    ));
  }

  void setMembers(List<UserEntity> users) {
    // Only set members if we haven't already modified the list manually?
    // Or just use this for initial loading.
    // Let's assume this is for initial load.
    // Check if we already have members to avoid overwriting user edits if called purely on load?
    // For now, simple set is fine for initialization.
    if (users.isNotEmpty) {
      emit(state.copyWith(members: users));
    }
  }
}
