import 'package:freezed_annotation/freezed_annotation.dart';

part 'users_event.freezed.dart';

@freezed
class UsersEvent with _$UsersEvent {
  const factory UsersEvent.searchUsers(String query) = UsersSearchUsers;
  const factory UsersEvent.getUsersByIds(List<String> ids) = UsersGetUsersByIds;
  const factory UsersEvent.clearCache() = UsersClearCache;
}
