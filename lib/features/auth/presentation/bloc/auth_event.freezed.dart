// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(String email, String password) loginRequested,
    required TResult Function(String email, String password) registerRequested,
    required TResult Function() logoutRequested,
    required TResult Function(UserEntity? user) userChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(String email, String password)? loginRequested,
    TResult? Function(String email, String password)? registerRequested,
    TResult? Function()? logoutRequested,
    TResult? Function(UserEntity? user)? userChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(String email, String password)? loginRequested,
    TResult Function(String email, String password)? registerRequested,
    TResult Function()? logoutRequested,
    TResult Function(UserEntity? user)? userChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthAppStarted value) appStarted,
    required TResult Function(AuthLoginRequested value) loginRequested,
    required TResult Function(AuthRegisterRequested value) registerRequested,
    required TResult Function(AuthLogoutRequested value) logoutRequested,
    required TResult Function(AuthUserChanged value) userChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthAppStarted value)? appStarted,
    TResult? Function(AuthLoginRequested value)? loginRequested,
    TResult? Function(AuthRegisterRequested value)? registerRequested,
    TResult? Function(AuthLogoutRequested value)? logoutRequested,
    TResult? Function(AuthUserChanged value)? userChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthAppStarted value)? appStarted,
    TResult Function(AuthLoginRequested value)? loginRequested,
    TResult Function(AuthRegisterRequested value)? registerRequested,
    TResult Function(AuthLogoutRequested value)? logoutRequested,
    TResult Function(AuthUserChanged value)? userChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthAppStartedImplCopyWith<$Res> {
  factory _$$AuthAppStartedImplCopyWith(_$AuthAppStartedImpl value,
          $Res Function(_$AuthAppStartedImpl) then) =
      __$$AuthAppStartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthAppStartedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthAppStartedImpl>
    implements _$$AuthAppStartedImplCopyWith<$Res> {
  __$$AuthAppStartedImplCopyWithImpl(
      _$AuthAppStartedImpl _value, $Res Function(_$AuthAppStartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthAppStartedImpl implements AuthAppStarted {
  const _$AuthAppStartedImpl();

  @override
  String toString() {
    return 'AuthEvent.appStarted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthAppStartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(String email, String password) loginRequested,
    required TResult Function(String email, String password) registerRequested,
    required TResult Function() logoutRequested,
    required TResult Function(UserEntity? user) userChanged,
  }) {
    return appStarted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(String email, String password)? loginRequested,
    TResult? Function(String email, String password)? registerRequested,
    TResult? Function()? logoutRequested,
    TResult? Function(UserEntity? user)? userChanged,
  }) {
    return appStarted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(String email, String password)? loginRequested,
    TResult Function(String email, String password)? registerRequested,
    TResult Function()? logoutRequested,
    TResult Function(UserEntity? user)? userChanged,
    required TResult orElse(),
  }) {
    if (appStarted != null) {
      return appStarted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthAppStarted value) appStarted,
    required TResult Function(AuthLoginRequested value) loginRequested,
    required TResult Function(AuthRegisterRequested value) registerRequested,
    required TResult Function(AuthLogoutRequested value) logoutRequested,
    required TResult Function(AuthUserChanged value) userChanged,
  }) {
    return appStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthAppStarted value)? appStarted,
    TResult? Function(AuthLoginRequested value)? loginRequested,
    TResult? Function(AuthRegisterRequested value)? registerRequested,
    TResult? Function(AuthLogoutRequested value)? logoutRequested,
    TResult? Function(AuthUserChanged value)? userChanged,
  }) {
    return appStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthAppStarted value)? appStarted,
    TResult Function(AuthLoginRequested value)? loginRequested,
    TResult Function(AuthRegisterRequested value)? registerRequested,
    TResult Function(AuthLogoutRequested value)? logoutRequested,
    TResult Function(AuthUserChanged value)? userChanged,
    required TResult orElse(),
  }) {
    if (appStarted != null) {
      return appStarted(this);
    }
    return orElse();
  }
}

abstract class AuthAppStarted implements AuthEvent {
  const factory AuthAppStarted() = _$AuthAppStartedImpl;
}

/// @nodoc
abstract class _$$AuthLoginRequestedImplCopyWith<$Res> {
  factory _$$AuthLoginRequestedImplCopyWith(_$AuthLoginRequestedImpl value,
          $Res Function(_$AuthLoginRequestedImpl) then) =
      __$$AuthLoginRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$AuthLoginRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthLoginRequestedImpl>
    implements _$$AuthLoginRequestedImplCopyWith<$Res> {
  __$$AuthLoginRequestedImplCopyWithImpl(_$AuthLoginRequestedImpl _value,
      $Res Function(_$AuthLoginRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$AuthLoginRequestedImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthLoginRequestedImpl implements AuthLoginRequested {
  const _$AuthLoginRequestedImpl(this.email, this.password);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvent.loginRequested(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthLoginRequestedImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthLoginRequestedImplCopyWith<_$AuthLoginRequestedImpl> get copyWith =>
      __$$AuthLoginRequestedImplCopyWithImpl<_$AuthLoginRequestedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(String email, String password) loginRequested,
    required TResult Function(String email, String password) registerRequested,
    required TResult Function() logoutRequested,
    required TResult Function(UserEntity? user) userChanged,
  }) {
    return loginRequested(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(String email, String password)? loginRequested,
    TResult? Function(String email, String password)? registerRequested,
    TResult? Function()? logoutRequested,
    TResult? Function(UserEntity? user)? userChanged,
  }) {
    return loginRequested?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(String email, String password)? loginRequested,
    TResult Function(String email, String password)? registerRequested,
    TResult Function()? logoutRequested,
    TResult Function(UserEntity? user)? userChanged,
    required TResult orElse(),
  }) {
    if (loginRequested != null) {
      return loginRequested(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthAppStarted value) appStarted,
    required TResult Function(AuthLoginRequested value) loginRequested,
    required TResult Function(AuthRegisterRequested value) registerRequested,
    required TResult Function(AuthLogoutRequested value) logoutRequested,
    required TResult Function(AuthUserChanged value) userChanged,
  }) {
    return loginRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthAppStarted value)? appStarted,
    TResult? Function(AuthLoginRequested value)? loginRequested,
    TResult? Function(AuthRegisterRequested value)? registerRequested,
    TResult? Function(AuthLogoutRequested value)? logoutRequested,
    TResult? Function(AuthUserChanged value)? userChanged,
  }) {
    return loginRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthAppStarted value)? appStarted,
    TResult Function(AuthLoginRequested value)? loginRequested,
    TResult Function(AuthRegisterRequested value)? registerRequested,
    TResult Function(AuthLogoutRequested value)? logoutRequested,
    TResult Function(AuthUserChanged value)? userChanged,
    required TResult orElse(),
  }) {
    if (loginRequested != null) {
      return loginRequested(this);
    }
    return orElse();
  }
}

abstract class AuthLoginRequested implements AuthEvent {
  const factory AuthLoginRequested(final String email, final String password) =
      _$AuthLoginRequestedImpl;

  String get email;
  String get password;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthLoginRequestedImplCopyWith<_$AuthLoginRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthRegisterRequestedImplCopyWith<$Res> {
  factory _$$AuthRegisterRequestedImplCopyWith(
          _$AuthRegisterRequestedImpl value,
          $Res Function(_$AuthRegisterRequestedImpl) then) =
      __$$AuthRegisterRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$AuthRegisterRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthRegisterRequestedImpl>
    implements _$$AuthRegisterRequestedImplCopyWith<$Res> {
  __$$AuthRegisterRequestedImplCopyWithImpl(_$AuthRegisterRequestedImpl _value,
      $Res Function(_$AuthRegisterRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$AuthRegisterRequestedImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthRegisterRequestedImpl implements AuthRegisterRequested {
  const _$AuthRegisterRequestedImpl(this.email, this.password);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvent.registerRequested(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthRegisterRequestedImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthRegisterRequestedImplCopyWith<_$AuthRegisterRequestedImpl>
      get copyWith => __$$AuthRegisterRequestedImplCopyWithImpl<
          _$AuthRegisterRequestedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(String email, String password) loginRequested,
    required TResult Function(String email, String password) registerRequested,
    required TResult Function() logoutRequested,
    required TResult Function(UserEntity? user) userChanged,
  }) {
    return registerRequested(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(String email, String password)? loginRequested,
    TResult? Function(String email, String password)? registerRequested,
    TResult? Function()? logoutRequested,
    TResult? Function(UserEntity? user)? userChanged,
  }) {
    return registerRequested?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(String email, String password)? loginRequested,
    TResult Function(String email, String password)? registerRequested,
    TResult Function()? logoutRequested,
    TResult Function(UserEntity? user)? userChanged,
    required TResult orElse(),
  }) {
    if (registerRequested != null) {
      return registerRequested(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthAppStarted value) appStarted,
    required TResult Function(AuthLoginRequested value) loginRequested,
    required TResult Function(AuthRegisterRequested value) registerRequested,
    required TResult Function(AuthLogoutRequested value) logoutRequested,
    required TResult Function(AuthUserChanged value) userChanged,
  }) {
    return registerRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthAppStarted value)? appStarted,
    TResult? Function(AuthLoginRequested value)? loginRequested,
    TResult? Function(AuthRegisterRequested value)? registerRequested,
    TResult? Function(AuthLogoutRequested value)? logoutRequested,
    TResult? Function(AuthUserChanged value)? userChanged,
  }) {
    return registerRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthAppStarted value)? appStarted,
    TResult Function(AuthLoginRequested value)? loginRequested,
    TResult Function(AuthRegisterRequested value)? registerRequested,
    TResult Function(AuthLogoutRequested value)? logoutRequested,
    TResult Function(AuthUserChanged value)? userChanged,
    required TResult orElse(),
  }) {
    if (registerRequested != null) {
      return registerRequested(this);
    }
    return orElse();
  }
}

abstract class AuthRegisterRequested implements AuthEvent {
  const factory AuthRegisterRequested(
      final String email, final String password) = _$AuthRegisterRequestedImpl;

  String get email;
  String get password;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthRegisterRequestedImplCopyWith<_$AuthRegisterRequestedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthLogoutRequestedImplCopyWith<$Res> {
  factory _$$AuthLogoutRequestedImplCopyWith(_$AuthLogoutRequestedImpl value,
          $Res Function(_$AuthLogoutRequestedImpl) then) =
      __$$AuthLogoutRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthLogoutRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthLogoutRequestedImpl>
    implements _$$AuthLogoutRequestedImplCopyWith<$Res> {
  __$$AuthLogoutRequestedImplCopyWithImpl(_$AuthLogoutRequestedImpl _value,
      $Res Function(_$AuthLogoutRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthLogoutRequestedImpl implements AuthLogoutRequested {
  const _$AuthLogoutRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.logoutRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthLogoutRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(String email, String password) loginRequested,
    required TResult Function(String email, String password) registerRequested,
    required TResult Function() logoutRequested,
    required TResult Function(UserEntity? user) userChanged,
  }) {
    return logoutRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(String email, String password)? loginRequested,
    TResult? Function(String email, String password)? registerRequested,
    TResult? Function()? logoutRequested,
    TResult? Function(UserEntity? user)? userChanged,
  }) {
    return logoutRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(String email, String password)? loginRequested,
    TResult Function(String email, String password)? registerRequested,
    TResult Function()? logoutRequested,
    TResult Function(UserEntity? user)? userChanged,
    required TResult orElse(),
  }) {
    if (logoutRequested != null) {
      return logoutRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthAppStarted value) appStarted,
    required TResult Function(AuthLoginRequested value) loginRequested,
    required TResult Function(AuthRegisterRequested value) registerRequested,
    required TResult Function(AuthLogoutRequested value) logoutRequested,
    required TResult Function(AuthUserChanged value) userChanged,
  }) {
    return logoutRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthAppStarted value)? appStarted,
    TResult? Function(AuthLoginRequested value)? loginRequested,
    TResult? Function(AuthRegisterRequested value)? registerRequested,
    TResult? Function(AuthLogoutRequested value)? logoutRequested,
    TResult? Function(AuthUserChanged value)? userChanged,
  }) {
    return logoutRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthAppStarted value)? appStarted,
    TResult Function(AuthLoginRequested value)? loginRequested,
    TResult Function(AuthRegisterRequested value)? registerRequested,
    TResult Function(AuthLogoutRequested value)? logoutRequested,
    TResult Function(AuthUserChanged value)? userChanged,
    required TResult orElse(),
  }) {
    if (logoutRequested != null) {
      return logoutRequested(this);
    }
    return orElse();
  }
}

abstract class AuthLogoutRequested implements AuthEvent {
  const factory AuthLogoutRequested() = _$AuthLogoutRequestedImpl;
}

/// @nodoc
abstract class _$$AuthUserChangedImplCopyWith<$Res> {
  factory _$$AuthUserChangedImplCopyWith(_$AuthUserChangedImpl value,
          $Res Function(_$AuthUserChangedImpl) then) =
      __$$AuthUserChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserEntity? user});
}

/// @nodoc
class __$$AuthUserChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthUserChangedImpl>
    implements _$$AuthUserChangedImplCopyWith<$Res> {
  __$$AuthUserChangedImplCopyWithImpl(
      _$AuthUserChangedImpl _value, $Res Function(_$AuthUserChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(_$AuthUserChangedImpl(
      freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity?,
    ));
  }
}

/// @nodoc

class _$AuthUserChangedImpl implements AuthUserChanged {
  const _$AuthUserChangedImpl(this.user);

  @override
  final UserEntity? user;

  @override
  String toString() {
    return 'AuthEvent.userChanged(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUserChangedImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUserChangedImplCopyWith<_$AuthUserChangedImpl> get copyWith =>
      __$$AuthUserChangedImplCopyWithImpl<_$AuthUserChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(String email, String password) loginRequested,
    required TResult Function(String email, String password) registerRequested,
    required TResult Function() logoutRequested,
    required TResult Function(UserEntity? user) userChanged,
  }) {
    return userChanged(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(String email, String password)? loginRequested,
    TResult? Function(String email, String password)? registerRequested,
    TResult? Function()? logoutRequested,
    TResult? Function(UserEntity? user)? userChanged,
  }) {
    return userChanged?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(String email, String password)? loginRequested,
    TResult Function(String email, String password)? registerRequested,
    TResult Function()? logoutRequested,
    TResult Function(UserEntity? user)? userChanged,
    required TResult orElse(),
  }) {
    if (userChanged != null) {
      return userChanged(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthAppStarted value) appStarted,
    required TResult Function(AuthLoginRequested value) loginRequested,
    required TResult Function(AuthRegisterRequested value) registerRequested,
    required TResult Function(AuthLogoutRequested value) logoutRequested,
    required TResult Function(AuthUserChanged value) userChanged,
  }) {
    return userChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthAppStarted value)? appStarted,
    TResult? Function(AuthLoginRequested value)? loginRequested,
    TResult? Function(AuthRegisterRequested value)? registerRequested,
    TResult? Function(AuthLogoutRequested value)? logoutRequested,
    TResult? Function(AuthUserChanged value)? userChanged,
  }) {
    return userChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthAppStarted value)? appStarted,
    TResult Function(AuthLoginRequested value)? loginRequested,
    TResult Function(AuthRegisterRequested value)? registerRequested,
    TResult Function(AuthLogoutRequested value)? logoutRequested,
    TResult Function(AuthUserChanged value)? userChanged,
    required TResult orElse(),
  }) {
    if (userChanged != null) {
      return userChanged(this);
    }
    return orElse();
  }
}

abstract class AuthUserChanged implements AuthEvent {
  const factory AuthUserChanged(final UserEntity? user) = _$AuthUserChangedImpl;

  UserEntity? get user;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthUserChangedImplCopyWith<_$AuthUserChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
