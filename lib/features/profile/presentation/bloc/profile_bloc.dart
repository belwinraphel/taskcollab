import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/update_profile.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;
  final UpdateProfile updateProfile;

  ProfileBloc({
    required this.getProfile,
    required this.updateProfile,
  }) : super(ProfileInitial()) {
    on<ProfileLoadRequested>(_onLoadRequested);
    on<ProfileUpdateRequested>(_onUpdateRequested);
  }

  Future<void> _onLoadRequested(
      ProfileLoadRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await getProfile(GetProfileParams(userId: event.userId));
    result.fold(
      (failure) => emit(ProfileError(failure.toString())),
      (user) => emit(ProfileLoaded(user)),
    );
  }

  Future<void> _onUpdateRequested(
      ProfileUpdateRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await updateProfile(UpdateProfileParams(user: event.user));
    result.fold(
      (failure) => emit(ProfileError(failure.toString())),
      (user) => emit(ProfileLoaded(user)),
    );
  }
}
