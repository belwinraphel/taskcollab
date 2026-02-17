import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/repositories/user_repository.dart';
import 'users_event.dart';
import 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepository userRepository;

  UsersBloc({required this.userRepository})
      : super(const UsersState.initial()) {
    on<UsersSearchUsers>(_onSearchUsers, transformer: _debounceTransformer);
    on<UsersGetUsersByIds>(_onGetUsersByIds);
    on<UsersClearCache>(_onClearCache);
  }

  // Debounce transformer for search
  Stream<UsersSearchUsers> _debounceTransformer(
    Stream<UsersSearchUsers> events,
    EventMapper<UsersSearchUsers> mapper,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 500))
        .switchMap(mapper);
  }

  Future<void> _onSearchUsers(
      UsersSearchUsers event, Emitter<UsersState> emit) async {
    if (event.query.isEmpty) {
      emit(const UsersState.initial());
      return;
    }

    emit(const UsersState.loading());
    final result = await userRepository.searchUsers(event.query);
    result.fold(
      (failure) => emit(UsersState.error(failure.message)),
      (users) => emit(UsersState.loaded(users)),
    );
  }

  Future<void> _onGetUsersByIds(
      UsersGetUsersByIds event, Emitter<UsersState> emit) async {
    emit(const UsersState.loading());
    final result = await userRepository.getUsersByIds(event.ids);
    result.fold(
      (failure) => emit(UsersState.error(failure.message)),
      (users) => emit(UsersState.loaded(users)),
    );
  }

  void _onClearCache(UsersClearCache event, Emitter<UsersState> emit) {
    userRepository.clearCache();
    emit(const UsersState.initial());
  }
}
