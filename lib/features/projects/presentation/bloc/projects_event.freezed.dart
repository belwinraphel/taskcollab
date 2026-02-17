// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'projects_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProjectsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name, String description) createProject,
    required TResult Function(Project project) updateProject,
    required TResult Function(String projectId) deleteProject,
    required TResult Function(String projectId, String userId) addMember,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String name, String description)? createProject,
    TResult? Function(Project project)? updateProject,
    TResult? Function(String projectId)? deleteProject,
    TResult? Function(String projectId, String userId)? addMember,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name, String description)? createProject,
    TResult Function(Project project)? updateProject,
    TResult Function(String projectId)? deleteProject,
    TResult Function(String projectId, String userId)? addMember,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsStarted value) started,
    required TResult Function(ProjectsCreateProject value) createProject,
    required TResult Function(ProjectsUpdateProject value) updateProject,
    required TResult Function(ProjectsDeleteProject value) deleteProject,
    required TResult Function(ProjectsAddMember value) addMember,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsStarted value)? started,
    TResult? Function(ProjectsCreateProject value)? createProject,
    TResult? Function(ProjectsUpdateProject value)? updateProject,
    TResult? Function(ProjectsDeleteProject value)? deleteProject,
    TResult? Function(ProjectsAddMember value)? addMember,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsStarted value)? started,
    TResult Function(ProjectsCreateProject value)? createProject,
    TResult Function(ProjectsUpdateProject value)? updateProject,
    TResult Function(ProjectsDeleteProject value)? deleteProject,
    TResult Function(ProjectsAddMember value)? addMember,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectsEventCopyWith<$Res> {
  factory $ProjectsEventCopyWith(
          ProjectsEvent value, $Res Function(ProjectsEvent) then) =
      _$ProjectsEventCopyWithImpl<$Res, ProjectsEvent>;
}

/// @nodoc
class _$ProjectsEventCopyWithImpl<$Res, $Val extends ProjectsEvent>
    implements $ProjectsEventCopyWith<$Res> {
  _$ProjectsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ProjectsStartedImplCopyWith<$Res> {
  factory _$$ProjectsStartedImplCopyWith(_$ProjectsStartedImpl value,
          $Res Function(_$ProjectsStartedImpl) then) =
      __$$ProjectsStartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProjectsStartedImplCopyWithImpl<$Res>
    extends _$ProjectsEventCopyWithImpl<$Res, _$ProjectsStartedImpl>
    implements _$$ProjectsStartedImplCopyWith<$Res> {
  __$$ProjectsStartedImplCopyWithImpl(
      _$ProjectsStartedImpl _value, $Res Function(_$ProjectsStartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProjectsStartedImpl implements ProjectsStarted {
  const _$ProjectsStartedImpl();

  @override
  String toString() {
    return 'ProjectsEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProjectsStartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name, String description) createProject,
    required TResult Function(Project project) updateProject,
    required TResult Function(String projectId) deleteProject,
    required TResult Function(String projectId, String userId) addMember,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String name, String description)? createProject,
    TResult? Function(Project project)? updateProject,
    TResult? Function(String projectId)? deleteProject,
    TResult? Function(String projectId, String userId)? addMember,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name, String description)? createProject,
    TResult Function(Project project)? updateProject,
    TResult Function(String projectId)? deleteProject,
    TResult Function(String projectId, String userId)? addMember,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsStarted value) started,
    required TResult Function(ProjectsCreateProject value) createProject,
    required TResult Function(ProjectsUpdateProject value) updateProject,
    required TResult Function(ProjectsDeleteProject value) deleteProject,
    required TResult Function(ProjectsAddMember value) addMember,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsStarted value)? started,
    TResult? Function(ProjectsCreateProject value)? createProject,
    TResult? Function(ProjectsUpdateProject value)? updateProject,
    TResult? Function(ProjectsDeleteProject value)? deleteProject,
    TResult? Function(ProjectsAddMember value)? addMember,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsStarted value)? started,
    TResult Function(ProjectsCreateProject value)? createProject,
    TResult Function(ProjectsUpdateProject value)? updateProject,
    TResult Function(ProjectsDeleteProject value)? deleteProject,
    TResult Function(ProjectsAddMember value)? addMember,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class ProjectsStarted implements ProjectsEvent {
  const factory ProjectsStarted() = _$ProjectsStartedImpl;
}

/// @nodoc
abstract class _$$ProjectsCreateProjectImplCopyWith<$Res> {
  factory _$$ProjectsCreateProjectImplCopyWith(
          _$ProjectsCreateProjectImpl value,
          $Res Function(_$ProjectsCreateProjectImpl) then) =
      __$$ProjectsCreateProjectImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name, String description});
}

/// @nodoc
class __$$ProjectsCreateProjectImplCopyWithImpl<$Res>
    extends _$ProjectsEventCopyWithImpl<$Res, _$ProjectsCreateProjectImpl>
    implements _$$ProjectsCreateProjectImplCopyWith<$Res> {
  __$$ProjectsCreateProjectImplCopyWithImpl(_$ProjectsCreateProjectImpl _value,
      $Res Function(_$ProjectsCreateProjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_$ProjectsCreateProjectImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProjectsCreateProjectImpl implements ProjectsCreateProject {
  const _$ProjectsCreateProjectImpl(this.name, this.description);

  @override
  final String name;
  @override
  final String description;

  @override
  String toString() {
    return 'ProjectsEvent.createProject(name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectsCreateProjectImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, description);

  /// Create a copy of ProjectsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectsCreateProjectImplCopyWith<_$ProjectsCreateProjectImpl>
      get copyWith => __$$ProjectsCreateProjectImplCopyWithImpl<
          _$ProjectsCreateProjectImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name, String description) createProject,
    required TResult Function(Project project) updateProject,
    required TResult Function(String projectId) deleteProject,
    required TResult Function(String projectId, String userId) addMember,
  }) {
    return createProject(name, description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String name, String description)? createProject,
    TResult? Function(Project project)? updateProject,
    TResult? Function(String projectId)? deleteProject,
    TResult? Function(String projectId, String userId)? addMember,
  }) {
    return createProject?.call(name, description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name, String description)? createProject,
    TResult Function(Project project)? updateProject,
    TResult Function(String projectId)? deleteProject,
    TResult Function(String projectId, String userId)? addMember,
    required TResult orElse(),
  }) {
    if (createProject != null) {
      return createProject(name, description);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsStarted value) started,
    required TResult Function(ProjectsCreateProject value) createProject,
    required TResult Function(ProjectsUpdateProject value) updateProject,
    required TResult Function(ProjectsDeleteProject value) deleteProject,
    required TResult Function(ProjectsAddMember value) addMember,
  }) {
    return createProject(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsStarted value)? started,
    TResult? Function(ProjectsCreateProject value)? createProject,
    TResult? Function(ProjectsUpdateProject value)? updateProject,
    TResult? Function(ProjectsDeleteProject value)? deleteProject,
    TResult? Function(ProjectsAddMember value)? addMember,
  }) {
    return createProject?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsStarted value)? started,
    TResult Function(ProjectsCreateProject value)? createProject,
    TResult Function(ProjectsUpdateProject value)? updateProject,
    TResult Function(ProjectsDeleteProject value)? deleteProject,
    TResult Function(ProjectsAddMember value)? addMember,
    required TResult orElse(),
  }) {
    if (createProject != null) {
      return createProject(this);
    }
    return orElse();
  }
}

abstract class ProjectsCreateProject implements ProjectsEvent {
  const factory ProjectsCreateProject(
          final String name, final String description) =
      _$ProjectsCreateProjectImpl;

  String get name;
  String get description;

  /// Create a copy of ProjectsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectsCreateProjectImplCopyWith<_$ProjectsCreateProjectImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProjectsUpdateProjectImplCopyWith<$Res> {
  factory _$$ProjectsUpdateProjectImplCopyWith(
          _$ProjectsUpdateProjectImpl value,
          $Res Function(_$ProjectsUpdateProjectImpl) then) =
      __$$ProjectsUpdateProjectImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Project project});
}

/// @nodoc
class __$$ProjectsUpdateProjectImplCopyWithImpl<$Res>
    extends _$ProjectsEventCopyWithImpl<$Res, _$ProjectsUpdateProjectImpl>
    implements _$$ProjectsUpdateProjectImplCopyWith<$Res> {
  __$$ProjectsUpdateProjectImplCopyWithImpl(_$ProjectsUpdateProjectImpl _value,
      $Res Function(_$ProjectsUpdateProjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? project = null,
  }) {
    return _then(_$ProjectsUpdateProjectImpl(
      null == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as Project,
    ));
  }
}

/// @nodoc

class _$ProjectsUpdateProjectImpl implements ProjectsUpdateProject {
  const _$ProjectsUpdateProjectImpl(this.project);

  @override
  final Project project;

  @override
  String toString() {
    return 'ProjectsEvent.updateProject(project: $project)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectsUpdateProjectImpl &&
            (identical(other.project, project) || other.project == project));
  }

  @override
  int get hashCode => Object.hash(runtimeType, project);

  /// Create a copy of ProjectsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectsUpdateProjectImplCopyWith<_$ProjectsUpdateProjectImpl>
      get copyWith => __$$ProjectsUpdateProjectImplCopyWithImpl<
          _$ProjectsUpdateProjectImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name, String description) createProject,
    required TResult Function(Project project) updateProject,
    required TResult Function(String projectId) deleteProject,
    required TResult Function(String projectId, String userId) addMember,
  }) {
    return updateProject(project);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String name, String description)? createProject,
    TResult? Function(Project project)? updateProject,
    TResult? Function(String projectId)? deleteProject,
    TResult? Function(String projectId, String userId)? addMember,
  }) {
    return updateProject?.call(project);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name, String description)? createProject,
    TResult Function(Project project)? updateProject,
    TResult Function(String projectId)? deleteProject,
    TResult Function(String projectId, String userId)? addMember,
    required TResult orElse(),
  }) {
    if (updateProject != null) {
      return updateProject(project);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsStarted value) started,
    required TResult Function(ProjectsCreateProject value) createProject,
    required TResult Function(ProjectsUpdateProject value) updateProject,
    required TResult Function(ProjectsDeleteProject value) deleteProject,
    required TResult Function(ProjectsAddMember value) addMember,
  }) {
    return updateProject(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsStarted value)? started,
    TResult? Function(ProjectsCreateProject value)? createProject,
    TResult? Function(ProjectsUpdateProject value)? updateProject,
    TResult? Function(ProjectsDeleteProject value)? deleteProject,
    TResult? Function(ProjectsAddMember value)? addMember,
  }) {
    return updateProject?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsStarted value)? started,
    TResult Function(ProjectsCreateProject value)? createProject,
    TResult Function(ProjectsUpdateProject value)? updateProject,
    TResult Function(ProjectsDeleteProject value)? deleteProject,
    TResult Function(ProjectsAddMember value)? addMember,
    required TResult orElse(),
  }) {
    if (updateProject != null) {
      return updateProject(this);
    }
    return orElse();
  }
}

abstract class ProjectsUpdateProject implements ProjectsEvent {
  const factory ProjectsUpdateProject(final Project project) =
      _$ProjectsUpdateProjectImpl;

  Project get project;

  /// Create a copy of ProjectsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectsUpdateProjectImplCopyWith<_$ProjectsUpdateProjectImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProjectsDeleteProjectImplCopyWith<$Res> {
  factory _$$ProjectsDeleteProjectImplCopyWith(
          _$ProjectsDeleteProjectImpl value,
          $Res Function(_$ProjectsDeleteProjectImpl) then) =
      __$$ProjectsDeleteProjectImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String projectId});
}

/// @nodoc
class __$$ProjectsDeleteProjectImplCopyWithImpl<$Res>
    extends _$ProjectsEventCopyWithImpl<$Res, _$ProjectsDeleteProjectImpl>
    implements _$$ProjectsDeleteProjectImplCopyWith<$Res> {
  __$$ProjectsDeleteProjectImplCopyWithImpl(_$ProjectsDeleteProjectImpl _value,
      $Res Function(_$ProjectsDeleteProjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
  }) {
    return _then(_$ProjectsDeleteProjectImpl(
      null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProjectsDeleteProjectImpl implements ProjectsDeleteProject {
  const _$ProjectsDeleteProjectImpl(this.projectId);

  @override
  final String projectId;

  @override
  String toString() {
    return 'ProjectsEvent.deleteProject(projectId: $projectId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectsDeleteProjectImpl &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, projectId);

  /// Create a copy of ProjectsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectsDeleteProjectImplCopyWith<_$ProjectsDeleteProjectImpl>
      get copyWith => __$$ProjectsDeleteProjectImplCopyWithImpl<
          _$ProjectsDeleteProjectImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name, String description) createProject,
    required TResult Function(Project project) updateProject,
    required TResult Function(String projectId) deleteProject,
    required TResult Function(String projectId, String userId) addMember,
  }) {
    return deleteProject(projectId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String name, String description)? createProject,
    TResult? Function(Project project)? updateProject,
    TResult? Function(String projectId)? deleteProject,
    TResult? Function(String projectId, String userId)? addMember,
  }) {
    return deleteProject?.call(projectId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name, String description)? createProject,
    TResult Function(Project project)? updateProject,
    TResult Function(String projectId)? deleteProject,
    TResult Function(String projectId, String userId)? addMember,
    required TResult orElse(),
  }) {
    if (deleteProject != null) {
      return deleteProject(projectId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsStarted value) started,
    required TResult Function(ProjectsCreateProject value) createProject,
    required TResult Function(ProjectsUpdateProject value) updateProject,
    required TResult Function(ProjectsDeleteProject value) deleteProject,
    required TResult Function(ProjectsAddMember value) addMember,
  }) {
    return deleteProject(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsStarted value)? started,
    TResult? Function(ProjectsCreateProject value)? createProject,
    TResult? Function(ProjectsUpdateProject value)? updateProject,
    TResult? Function(ProjectsDeleteProject value)? deleteProject,
    TResult? Function(ProjectsAddMember value)? addMember,
  }) {
    return deleteProject?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsStarted value)? started,
    TResult Function(ProjectsCreateProject value)? createProject,
    TResult Function(ProjectsUpdateProject value)? updateProject,
    TResult Function(ProjectsDeleteProject value)? deleteProject,
    TResult Function(ProjectsAddMember value)? addMember,
    required TResult orElse(),
  }) {
    if (deleteProject != null) {
      return deleteProject(this);
    }
    return orElse();
  }
}

abstract class ProjectsDeleteProject implements ProjectsEvent {
  const factory ProjectsDeleteProject(final String projectId) =
      _$ProjectsDeleteProjectImpl;

  String get projectId;

  /// Create a copy of ProjectsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectsDeleteProjectImplCopyWith<_$ProjectsDeleteProjectImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProjectsAddMemberImplCopyWith<$Res> {
  factory _$$ProjectsAddMemberImplCopyWith(_$ProjectsAddMemberImpl value,
          $Res Function(_$ProjectsAddMemberImpl) then) =
      __$$ProjectsAddMemberImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String projectId, String userId});
}

/// @nodoc
class __$$ProjectsAddMemberImplCopyWithImpl<$Res>
    extends _$ProjectsEventCopyWithImpl<$Res, _$ProjectsAddMemberImpl>
    implements _$$ProjectsAddMemberImplCopyWith<$Res> {
  __$$ProjectsAddMemberImplCopyWithImpl(_$ProjectsAddMemberImpl _value,
      $Res Function(_$ProjectsAddMemberImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? userId = null,
  }) {
    return _then(_$ProjectsAddMemberImpl(
      null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProjectsAddMemberImpl implements ProjectsAddMember {
  const _$ProjectsAddMemberImpl(this.projectId, this.userId);

  @override
  final String projectId;
  @override
  final String userId;

  @override
  String toString() {
    return 'ProjectsEvent.addMember(projectId: $projectId, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectsAddMemberImpl &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, projectId, userId);

  /// Create a copy of ProjectsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectsAddMemberImplCopyWith<_$ProjectsAddMemberImpl> get copyWith =>
      __$$ProjectsAddMemberImplCopyWithImpl<_$ProjectsAddMemberImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name, String description) createProject,
    required TResult Function(Project project) updateProject,
    required TResult Function(String projectId) deleteProject,
    required TResult Function(String projectId, String userId) addMember,
  }) {
    return addMember(projectId, userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String name, String description)? createProject,
    TResult? Function(Project project)? updateProject,
    TResult? Function(String projectId)? deleteProject,
    TResult? Function(String projectId, String userId)? addMember,
  }) {
    return addMember?.call(projectId, userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name, String description)? createProject,
    TResult Function(Project project)? updateProject,
    TResult Function(String projectId)? deleteProject,
    TResult Function(String projectId, String userId)? addMember,
    required TResult orElse(),
  }) {
    if (addMember != null) {
      return addMember(projectId, userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsStarted value) started,
    required TResult Function(ProjectsCreateProject value) createProject,
    required TResult Function(ProjectsUpdateProject value) updateProject,
    required TResult Function(ProjectsDeleteProject value) deleteProject,
    required TResult Function(ProjectsAddMember value) addMember,
  }) {
    return addMember(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsStarted value)? started,
    TResult? Function(ProjectsCreateProject value)? createProject,
    TResult? Function(ProjectsUpdateProject value)? updateProject,
    TResult? Function(ProjectsDeleteProject value)? deleteProject,
    TResult? Function(ProjectsAddMember value)? addMember,
  }) {
    return addMember?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsStarted value)? started,
    TResult Function(ProjectsCreateProject value)? createProject,
    TResult Function(ProjectsUpdateProject value)? updateProject,
    TResult Function(ProjectsDeleteProject value)? deleteProject,
    TResult Function(ProjectsAddMember value)? addMember,
    required TResult orElse(),
  }) {
    if (addMember != null) {
      return addMember(this);
    }
    return orElse();
  }
}

abstract class ProjectsAddMember implements ProjectsEvent {
  const factory ProjectsAddMember(final String projectId, final String userId) =
      _$ProjectsAddMemberImpl;

  String get projectId;
  String get userId;

  /// Create a copy of ProjectsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectsAddMemberImplCopyWith<_$ProjectsAddMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
