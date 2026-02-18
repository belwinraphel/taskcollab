import 'package:freezed_annotation/freezed_annotation.dart';
import 'failures.dart';

part 'auth_failure.freezed.dart';

@freezed
class AuthFailure extends Failure with _$AuthFailure {
  const AuthFailure._();

  const factory AuthFailure.serverError() = _ServerError;
  const factory AuthFailure.emailAlreadyInUse() = _EmailAlreadyInUse;
  const factory AuthFailure.invalidEmailAndPasswordCombination() =
      _InvalidEmailAndPasswordCombination;
  const factory AuthFailure.networkError() = _NetworkError;
  const factory AuthFailure.userDisabled() = _UserDisabled;
  const factory AuthFailure.tokenRevoked() = _TokenRevoked;
  const factory AuthFailure.sessionExpired() = _SessionExpired;

  @override
  String get message {
    return map(
      serverError: (_) => 'Server error occurred. Please try again.',
      emailAlreadyInUse: (_) => 'Email is already in use.',
      invalidEmailAndPasswordCombination: (_) =>
          'Invalid email and password combination.',
      networkError: (_) => 'Network error. Please check your connection.',
      userDisabled: (_) => 'This user has been disabled.',
      tokenRevoked: (_) => 'Session expired. Please login again.',
      sessionExpired: (_) => 'Session expired. Please login again.',
    );
  }
}
