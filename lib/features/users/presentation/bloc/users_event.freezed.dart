// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UsersEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchUsers,
    required TResult Function(List<String> ids) getUsersByIds,
    required TResult Function() clearCache,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchUsers,
    TResult? Function(List<String> ids)? getUsersByIds,
    TResult? Function()? clearCache,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchUsers,
    TResult Function(List<String> ids)? getUsersByIds,
    TResult Function()? clearCache,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UsersSearchUsers value) searchUsers,
    required TResult Function(UsersGetUsersByIds value) getUsersByIds,
    required TResult Function(UsersClearCache value) clearCache,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UsersSearchUsers value)? searchUsers,
    TResult? Function(UsersGetUsersByIds value)? getUsersByIds,
    TResult? Function(UsersClearCache value)? clearCache,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UsersSearchUsers value)? searchUsers,
    TResult Function(UsersGetUsersByIds value)? getUsersByIds,
    TResult Function(UsersClearCache value)? clearCache,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsersEventCopyWith<$Res> {
  factory $UsersEventCopyWith(
          UsersEvent value, $Res Function(UsersEvent) then) =
      _$UsersEventCopyWithImpl<$Res, UsersEvent>;
}

/// @nodoc
class _$UsersEventCopyWithImpl<$Res, $Val extends UsersEvent>
    implements $UsersEventCopyWith<$Res> {
  _$UsersEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsersEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UsersSearchUsersImplCopyWith<$Res> {
  factory _$$UsersSearchUsersImplCopyWith(_$UsersSearchUsersImpl value,
          $Res Function(_$UsersSearchUsersImpl) then) =
      __$$UsersSearchUsersImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$UsersSearchUsersImplCopyWithImpl<$Res>
    extends _$UsersEventCopyWithImpl<$Res, _$UsersSearchUsersImpl>
    implements _$$UsersSearchUsersImplCopyWith<$Res> {
  __$$UsersSearchUsersImplCopyWithImpl(_$UsersSearchUsersImpl _value,
      $Res Function(_$UsersSearchUsersImpl) _then)
      : super(_value, _then);

  /// Create a copy of UsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_$UsersSearchUsersImpl(
      null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UsersSearchUsersImpl implements UsersSearchUsers {
  const _$UsersSearchUsersImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'UsersEvent.searchUsers(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsersSearchUsersImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of UsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsersSearchUsersImplCopyWith<_$UsersSearchUsersImpl> get copyWith =>
      __$$UsersSearchUsersImplCopyWithImpl<_$UsersSearchUsersImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchUsers,
    required TResult Function(List<String> ids) getUsersByIds,
    required TResult Function() clearCache,
  }) {
    return searchUsers(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchUsers,
    TResult? Function(List<String> ids)? getUsersByIds,
    TResult? Function()? clearCache,
  }) {
    return searchUsers?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchUsers,
    TResult Function(List<String> ids)? getUsersByIds,
    TResult Function()? clearCache,
    required TResult orElse(),
  }) {
    if (searchUsers != null) {
      return searchUsers(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UsersSearchUsers value) searchUsers,
    required TResult Function(UsersGetUsersByIds value) getUsersByIds,
    required TResult Function(UsersClearCache value) clearCache,
  }) {
    return searchUsers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UsersSearchUsers value)? searchUsers,
    TResult? Function(UsersGetUsersByIds value)? getUsersByIds,
    TResult? Function(UsersClearCache value)? clearCache,
  }) {
    return searchUsers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UsersSearchUsers value)? searchUsers,
    TResult Function(UsersGetUsersByIds value)? getUsersByIds,
    TResult Function(UsersClearCache value)? clearCache,
    required TResult orElse(),
  }) {
    if (searchUsers != null) {
      return searchUsers(this);
    }
    return orElse();
  }
}

abstract class UsersSearchUsers implements UsersEvent {
  const factory UsersSearchUsers(final String query) = _$UsersSearchUsersImpl;

  String get query;

  /// Create a copy of UsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsersSearchUsersImplCopyWith<_$UsersSearchUsersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UsersGetUsersByIdsImplCopyWith<$Res> {
  factory _$$UsersGetUsersByIdsImplCopyWith(_$UsersGetUsersByIdsImpl value,
          $Res Function(_$UsersGetUsersByIdsImpl) then) =
      __$$UsersGetUsersByIdsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> ids});
}

/// @nodoc
class __$$UsersGetUsersByIdsImplCopyWithImpl<$Res>
    extends _$UsersEventCopyWithImpl<$Res, _$UsersGetUsersByIdsImpl>
    implements _$$UsersGetUsersByIdsImplCopyWith<$Res> {
  __$$UsersGetUsersByIdsImplCopyWithImpl(_$UsersGetUsersByIdsImpl _value,
      $Res Function(_$UsersGetUsersByIdsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
  }) {
    return _then(_$UsersGetUsersByIdsImpl(
      null == ids
          ? _value._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$UsersGetUsersByIdsImpl implements UsersGetUsersByIds {
  const _$UsersGetUsersByIdsImpl(final List<String> ids) : _ids = ids;

  final List<String> _ids;
  @override
  List<String> get ids {
    if (_ids is EqualUnmodifiableListView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  @override
  String toString() {
    return 'UsersEvent.getUsersByIds(ids: $ids)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsersGetUsersByIdsImpl &&
            const DeepCollectionEquality().equals(other._ids, _ids));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_ids));

  /// Create a copy of UsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsersGetUsersByIdsImplCopyWith<_$UsersGetUsersByIdsImpl> get copyWith =>
      __$$UsersGetUsersByIdsImplCopyWithImpl<_$UsersGetUsersByIdsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchUsers,
    required TResult Function(List<String> ids) getUsersByIds,
    required TResult Function() clearCache,
  }) {
    return getUsersByIds(ids);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchUsers,
    TResult? Function(List<String> ids)? getUsersByIds,
    TResult? Function()? clearCache,
  }) {
    return getUsersByIds?.call(ids);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchUsers,
    TResult Function(List<String> ids)? getUsersByIds,
    TResult Function()? clearCache,
    required TResult orElse(),
  }) {
    if (getUsersByIds != null) {
      return getUsersByIds(ids);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UsersSearchUsers value) searchUsers,
    required TResult Function(UsersGetUsersByIds value) getUsersByIds,
    required TResult Function(UsersClearCache value) clearCache,
  }) {
    return getUsersByIds(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UsersSearchUsers value)? searchUsers,
    TResult? Function(UsersGetUsersByIds value)? getUsersByIds,
    TResult? Function(UsersClearCache value)? clearCache,
  }) {
    return getUsersByIds?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UsersSearchUsers value)? searchUsers,
    TResult Function(UsersGetUsersByIds value)? getUsersByIds,
    TResult Function(UsersClearCache value)? clearCache,
    required TResult orElse(),
  }) {
    if (getUsersByIds != null) {
      return getUsersByIds(this);
    }
    return orElse();
  }
}

abstract class UsersGetUsersByIds implements UsersEvent {
  const factory UsersGetUsersByIds(final List<String> ids) =
      _$UsersGetUsersByIdsImpl;

  List<String> get ids;

  /// Create a copy of UsersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsersGetUsersByIdsImplCopyWith<_$UsersGetUsersByIdsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UsersClearCacheImplCopyWith<$Res> {
  factory _$$UsersClearCacheImplCopyWith(_$UsersClearCacheImpl value,
          $Res Function(_$UsersClearCacheImpl) then) =
      __$$UsersClearCacheImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UsersClearCacheImplCopyWithImpl<$Res>
    extends _$UsersEventCopyWithImpl<$Res, _$UsersClearCacheImpl>
    implements _$$UsersClearCacheImplCopyWith<$Res> {
  __$$UsersClearCacheImplCopyWithImpl(
      _$UsersClearCacheImpl _value, $Res Function(_$UsersClearCacheImpl) _then)
      : super(_value, _then);

  /// Create a copy of UsersEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UsersClearCacheImpl implements UsersClearCache {
  const _$UsersClearCacheImpl();

  @override
  String toString() {
    return 'UsersEvent.clearCache()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UsersClearCacheImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchUsers,
    required TResult Function(List<String> ids) getUsersByIds,
    required TResult Function() clearCache,
  }) {
    return clearCache();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchUsers,
    TResult? Function(List<String> ids)? getUsersByIds,
    TResult? Function()? clearCache,
  }) {
    return clearCache?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchUsers,
    TResult Function(List<String> ids)? getUsersByIds,
    TResult Function()? clearCache,
    required TResult orElse(),
  }) {
    if (clearCache != null) {
      return clearCache();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UsersSearchUsers value) searchUsers,
    required TResult Function(UsersGetUsersByIds value) getUsersByIds,
    required TResult Function(UsersClearCache value) clearCache,
  }) {
    return clearCache(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UsersSearchUsers value)? searchUsers,
    TResult? Function(UsersGetUsersByIds value)? getUsersByIds,
    TResult? Function(UsersClearCache value)? clearCache,
  }) {
    return clearCache?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UsersSearchUsers value)? searchUsers,
    TResult Function(UsersGetUsersByIds value)? getUsersByIds,
    TResult Function(UsersClearCache value)? clearCache,
    required TResult orElse(),
  }) {
    if (clearCache != null) {
      return clearCache(this);
    }
    return orElse();
  }
}

abstract class UsersClearCache implements UsersEvent {
  const factory UsersClearCache() = _$UsersClearCacheImpl;
}
