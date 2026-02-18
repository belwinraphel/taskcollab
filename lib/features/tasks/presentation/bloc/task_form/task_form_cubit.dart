import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../users/domain/entities/user.dart';
import '../../../../users/domain/repositories/user_repository.dart';
import '../../../domain/entities/task.dart';
import 'task_form_state.dart';
export 'task_form_state.dart';

class TaskFormCubit extends Cubit<TaskFormState> {
  final UserRepository userRepository;

  TaskFormCubit({TaskEntity? task, required this.userRepository})
      : super(TaskFormState(
          title: task?.title ?? '',
          description: task?.description ?? '',
          assignees: task?.assignees
                  .map((a) => UserEntity(
                        id: a.id,
                        email: '', // Placeholder, will be updated if possible
                        displayName: a.name,
                        photoUrl: a.avatarUrl,
                      ))
                  .toList() ??
              [],
          dueDate: task?.dueDate ?? DateTime.now().add(const Duration(days: 7)),
          priority: task?.priority ?? TaskPriority.medium,
          isEditing: task != null,
        ));

  void titleChanged(String value) {
    emit(state.copyWith(title: value));
  }

  void descriptionChanged(String value) {
    emit(state.copyWith(description: value));
  }

  void priorityChanged(TaskPriority priority) {
    emit(state.copyWith(priority: priority));
  }

  void dueDateChanged(DateTime date) {
    emit(state.copyWith(dueDate: date));
  }

  void addAssignee(UserEntity user) {
    if (!state.assignees.any((u) => u.id == user.id)) {
      emit(state.copyWith(assignees: listPlus(state.assignees, user)));
    }
  }

  void removeAssignee(UserEntity user) {
    emit(state.copyWith(
      assignees: state.assignees.where((u) => u.id != user.id).toList(),
    ));
  }

  Future<void> loadProjectMembers(String projectId,
      {List<String>? additionalIds}) async {
    // 1. Get IDs of current assignees to ensure they are fetched
    final idsToFetch = state.assignees.map((u) => u.id).toSet();
    if (additionalIds != null) idsToFetch.addAll(additionalIds);

    // 2. We can't easily "get all project members" if we don't know their IDs.
    // The `additionalIds` usually comes from the Project entity (memberIds).
    // So the caller (UI) must pass `project.memberIds` to this method.

    if (idsToFetch.isNotEmpty) {
      final result = await userRepository.getUsersByIds(idsToFetch.toList());
      result.fold((_) {}, (users) {
        // Update selected assignees with full data
        final loadedMap = {for (var u in users) u.id: u};
        final updatedAssignees =
            state.assignees.map((a) => loadedMap[a.id] ?? a).toList();

        // Available members = all fetched users + any assignees not in fetched list (though they should be)
        // If fetching failed for some, we keep existing placeholder.
        // We want availableMembers to be the options shown in dropdown.
        // Merge users and updatedAssignees.
        final allUsers = [...users];
        for (final a in updatedAssignees) {
          if (!allUsers.any((u) => u.id == a.id)) {
            allUsers.add(a);
          }
        }

        emit(state.copyWith(
          assignees: updatedAssignees,
          availableMembers: allUsers,
        ));
      });
    }
  }

  List<T> listPlus<T>(List<T> list, T item) => List.from(list)..add(item);
}
