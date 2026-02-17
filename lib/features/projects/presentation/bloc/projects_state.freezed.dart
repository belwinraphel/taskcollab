// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'projects_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProjectsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Project> projects) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Project> projects)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Project> projects)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsInitial value) initial,
    required TResult Function(ProjectsLoading value) loading,
    required TResult Function(ProjectsLoaded value) loaded,
    required TResult Function(ProjectsError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsInitial value)? initial,
    TResult? Function(ProjectsLoading value)? loading,
    TResult? Function(ProjectsLoaded value)? loaded,
    TResult? Function(ProjectsError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsInitial value)? initial,
    TResult Function(ProjectsLoading value)? loading,
    TResult Function(ProjectsLoaded value)? loaded,
    TResult Function(ProjectsError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectsStateCopyWith<$Res> {
  factory $ProjectsStateCopyWith(
          ProjectsState value, $Res Function(ProjectsState) then) =
      _$ProjectsStateCopyWithImpl<$Res, ProjectsState>;
}

/// @nodoc
class _$ProjectsStateCopyWithImpl<$Res, $Val extends ProjectsState>
    implements $ProjectsStateCopyWith<$Res> {
  _$ProjectsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ProjectsInitialImplCopyWith<$Res> {
  factory _$$ProjectsInitialImplCopyWith(_$ProjectsInitialImpl value,
          $Res Function(_$ProjectsInitialImpl) then) =
      __$$ProjectsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProjectsInitialImplCopyWithImpl<$Res>
    extends _$ProjectsStateCopyWithImpl<$Res, _$ProjectsInitialImpl>
    implements _$$ProjectsInitialImplCopyWith<$Res> {
  __$$ProjectsInitialImplCopyWithImpl(
      _$ProjectsInitialImpl _value, $Res Function(_$ProjectsInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProjectsInitialImpl implements ProjectsInitial {
  const _$ProjectsInitialImpl();

  @override
  String toString() {
    return 'ProjectsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProjectsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Project> projects) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Project> projects)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Project> projects)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsInitial value) initial,
    required TResult Function(ProjectsLoading value) loading,
    required TResult Function(ProjectsLoaded value) loaded,
    required TResult Function(ProjectsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsInitial value)? initial,
    TResult? Function(ProjectsLoading value)? loading,
    TResult? Function(ProjectsLoaded value)? loaded,
    TResult? Function(ProjectsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsInitial value)? initial,
    TResult Function(ProjectsLoading value)? loading,
    TResult Function(ProjectsLoaded value)? loaded,
    TResult Function(ProjectsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ProjectsInitial implements ProjectsState {
  const factory ProjectsInitial() = _$ProjectsInitialImpl;
}

/// @nodoc
abstract class _$$ProjectsLoadingImplCopyWith<$Res> {
  factory _$$ProjectsLoadingImplCopyWith(_$ProjectsLoadingImpl value,
          $Res Function(_$ProjectsLoadingImpl) then) =
      __$$ProjectsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProjectsLoadingImplCopyWithImpl<$Res>
    extends _$ProjectsStateCopyWithImpl<$Res, _$ProjectsLoadingImpl>
    implements _$$ProjectsLoadingImplCopyWith<$Res> {
  __$$ProjectsLoadingImplCopyWithImpl(
      _$ProjectsLoadingImpl _value, $Res Function(_$ProjectsLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProjectsLoadingImpl implements ProjectsLoading {
  const _$ProjectsLoadingImpl();

  @override
  String toString() {
    return 'ProjectsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProjectsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Project> projects) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Project> projects)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Project> projects)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsInitial value) initial,
    required TResult Function(ProjectsLoading value) loading,
    required TResult Function(ProjectsLoaded value) loaded,
    required TResult Function(ProjectsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsInitial value)? initial,
    TResult? Function(ProjectsLoading value)? loading,
    TResult? Function(ProjectsLoaded value)? loaded,
    TResult? Function(ProjectsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsInitial value)? initial,
    TResult Function(ProjectsLoading value)? loading,
    TResult Function(ProjectsLoaded value)? loaded,
    TResult Function(ProjectsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ProjectsLoading implements ProjectsState {
  const factory ProjectsLoading() = _$ProjectsLoadingImpl;
}

/// @nodoc
abstract class _$$ProjectsLoadedImplCopyWith<$Res> {
  factory _$$ProjectsLoadedImplCopyWith(_$ProjectsLoadedImpl value,
          $Res Function(_$ProjectsLoadedImpl) then) =
      __$$ProjectsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Project> projects});
}

/// @nodoc
class __$$ProjectsLoadedImplCopyWithImpl<$Res>
    extends _$ProjectsStateCopyWithImpl<$Res, _$ProjectsLoadedImpl>
    implements _$$ProjectsLoadedImplCopyWith<$Res> {
  __$$ProjectsLoadedImplCopyWithImpl(
      _$ProjectsLoadedImpl _value, $Res Function(_$ProjectsLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projects = null,
  }) {
    return _then(_$ProjectsLoadedImpl(
      null == projects
          ? _value._projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<Project>,
    ));
  }
}

/// @nodoc

class _$ProjectsLoadedImpl implements ProjectsLoaded {
  const _$ProjectsLoadedImpl(final List<Project> projects)
      : _projects = projects;

  final List<Project> _projects;
  @override
  List<Project> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  @override
  String toString() {
    return 'ProjectsState.loaded(projects: $projects)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectsLoadedImpl &&
            const DeepCollectionEquality().equals(other._projects, _projects));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_projects));

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectsLoadedImplCopyWith<_$ProjectsLoadedImpl> get copyWith =>
      __$$ProjectsLoadedImplCopyWithImpl<_$ProjectsLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Project> projects) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(projects);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Project> projects)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(projects);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Project> projects)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(projects);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsInitial value) initial,
    required TResult Function(ProjectsLoading value) loading,
    required TResult Function(ProjectsLoaded value) loaded,
    required TResult Function(ProjectsError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsInitial value)? initial,
    TResult? Function(ProjectsLoading value)? loading,
    TResult? Function(ProjectsLoaded value)? loaded,
    TResult? Function(ProjectsError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsInitial value)? initial,
    TResult Function(ProjectsLoading value)? loading,
    TResult Function(ProjectsLoaded value)? loaded,
    TResult Function(ProjectsError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ProjectsLoaded implements ProjectsState {
  const factory ProjectsLoaded(final List<Project> projects) =
      _$ProjectsLoadedImpl;

  List<Project> get projects;

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectsLoadedImplCopyWith<_$ProjectsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProjectsErrorImplCopyWith<$Res> {
  factory _$$ProjectsErrorImplCopyWith(
          _$ProjectsErrorImpl value, $Res Function(_$ProjectsErrorImpl) then) =
      __$$ProjectsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ProjectsErrorImplCopyWithImpl<$Res>
    extends _$ProjectsStateCopyWithImpl<$Res, _$ProjectsErrorImpl>
    implements _$$ProjectsErrorImplCopyWith<$Res> {
  __$$ProjectsErrorImplCopyWithImpl(
      _$ProjectsErrorImpl _value, $Res Function(_$ProjectsErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ProjectsErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProjectsErrorImpl implements ProjectsError {
  const _$ProjectsErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ProjectsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectsErrorImplCopyWith<_$ProjectsErrorImpl> get copyWith =>
      __$$ProjectsErrorImplCopyWithImpl<_$ProjectsErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Project> projects) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Project> projects)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Project> projects)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsInitial value) initial,
    required TResult Function(ProjectsLoading value) loading,
    required TResult Function(ProjectsLoaded value) loaded,
    required TResult Function(ProjectsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsInitial value)? initial,
    TResult? Function(ProjectsLoading value)? loading,
    TResult? Function(ProjectsLoaded value)? loaded,
    TResult? Function(ProjectsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsInitial value)? initial,
    TResult Function(ProjectsLoading value)? loading,
    TResult Function(ProjectsLoaded value)? loaded,
    TResult Function(ProjectsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ProjectsError implements ProjectsState {
  const factory ProjectsError(final String message) = _$ProjectsErrorImpl;

  String get message;

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectsErrorImplCopyWith<_$ProjectsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
