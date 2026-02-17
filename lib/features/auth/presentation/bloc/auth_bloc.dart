import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/logout_user.dart';
import '../../domain/usecases/register_user.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/get_auth_stream.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/auth_failure.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final LogoutUser logoutUser;
  final GetCurrentUser getCurrentUser;
  final GetAuthStream getAuthStream;

  StreamSubscription<dynamic>? _authSubscription;

  AuthBloc({
    required this.loginUser,
    required this.registerUser,
    required this.logoutUser,
    required this.getCurrentUser,
    required this.getAuthStream,
  }) : super(const AuthState.initial()) {
    on<AuthAppStarted>(_onAppStarted);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthUserChanged>(_onUserChanged);
  }

  Future<void> _onAppStarted(
      AuthAppStarted event, Emitter<AuthState> emit) async {
    _authSubscription?.cancel();
    _authSubscription = getAuthStream().listen(
      (user) => add(AuthEvent.userChanged(user)),
      onError: (error) {
        // Handle stream errors if any
      },
    );
  }

  Future<void> _onUserChanged(
      AuthUserChanged event, Emitter<AuthState> emit) async {
    if (event.user != null) {
      emit(AuthState.authenticated(event.user!));
    } else {
      // Check if it was a manual logout vs session expiry
      // For now, if user is null, it's unauthenticated.
      // To really detect session expiry, we'd need more info from the stream or data source.
      // But typically, if existing state was authenticated and now it's null without logout event, it might be expiry.
      // For simplicity in this iteration:
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await loginUser(
        LoginParams(email: event.email, password: event.password));
    result.fold(
      (failure) => emit(
          AuthState.error(AuthFailure.serverError())), // Simple mapping for now
      (_) {
        // Stream will update state
      },
    );
  }

  Future<void> _onRegisterRequested(
      AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await registerUser(
        RegisterParams(email: event.email, password: event.password));
    result.fold(
      (failure) => emit(AuthState.error(AuthFailure.serverError())),
      (_) {
        // Stream will update state
      },
    );
  }

  Future<void> _onLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await logoutUser(NoParams());
    result.fold(
      (failure) => emit(AuthState.error(AuthFailure.serverError())),
      (_) => emit(const AuthState
          .unauthenticated()), // Stream will also trigger, but this is immediate feedback
    );
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
