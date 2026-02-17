import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/auth_failure.dart';
import '../../domain/entities/user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.authenticated(UserEntity user) = AuthAuthenticated;
  const factory AuthState.unauthenticated(
      {@Default(false) bool sessionExpired}) = AuthUnauthenticated;
  const factory AuthState.error(AuthFailure failure) = AuthError;
}
