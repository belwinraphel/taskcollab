import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.appStarted() = AuthAppStarted;
  const factory AuthEvent.loginRequested(String email, String password) =
      AuthLoginRequested;
  const factory AuthEvent.registerRequested(
          String email, String password, String displayName) =
      AuthRegisterRequested;
  const factory AuthEvent.logoutRequested() = AuthLogoutRequested;
  const factory AuthEvent.userChanged(UserEntity? user) = AuthUserChanged;
}
