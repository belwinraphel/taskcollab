// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TasksEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String projectId) started,
    required TResult Function(TaskEntity task) createTask,
    required TResult Function(TaskEntity task) updateTask,
    required TResult Function(String projectId, String taskId) deleteTask,
    required TResult Function(TaskStatus filter) filterChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String projectId)? started,
    TResult? Function(TaskEntity task)? createTask,
    TResult? Function(TaskEntity task)? updateTask,
    TResult? Function(String projectId, String taskId)? deleteTask,
    TResult? Function(TaskStatus filter)? filterChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String projectId)? started,
    TResult Function(TaskEntity task)? createTask,
    TResult Function(TaskEntity task)? updateTask,
    TResult Function(String projectId, String taskId)? deleteTask,
    TResult Function(TaskStatus filter)? filterChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TasksStarted value) started,
    required TResult Function(TasksCreateTask value) createTask,
    required TResult Function(TasksUpdateTask value) updateTask,
    required TResult Function(TasksDeleteTask value) deleteTask,
    required TResult Function(TasksFilterChanged value) filterChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TasksStarted value)? started,
    TResult? Function(TasksCreateTask value)? createTask,
    TResult? Function(TasksUpdateTask value)? updateTask,
    TResult? Function(TasksDeleteTask value)? deleteTask,
    TResult? Function(TasksFilterChanged value)? filterChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TasksStarted value)? started,
    TResult Function(TasksCreateTask value)? createTask,
    TResult Function(TasksUpdateTask value)? updateTask,
    TResult Function(TasksDeleteTask value)? deleteTask,
    TResult Function(TasksFilterChanged value)? filterChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasksEventCopyWith<$Res> {
  factory $TasksEventCopyWith(
          TasksEvent value, $Res Function(TasksEvent) then) =
      _$TasksEventCopyWithImpl<$Res, TasksEvent>;
}

/// @nodoc
class _$TasksEventCopyWithImpl<$Res, $Val extends TasksEvent>
    implements $TasksEventCopyWith<$Res> {
  _$TasksEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TasksEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TasksStartedImplCopyWith<$Res> {
  factory _$$TasksStartedImplCopyWith(
          _$TasksStartedImpl value, $Res Function(_$TasksStartedImpl) then) =
      __$$TasksStartedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String projectId});
}

/// @nodoc
class __$$TasksStartedImplCopyWithImpl<$Res>
    extends _$TasksEventCopyWithImpl<$Res, _$TasksStartedImpl>
    implements _$$TasksStartedImplCopyWith<$Res> {
  __$$TasksStartedImplCopyWithImpl(
      _$TasksStartedImpl _value, $Res Function(_$TasksStartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TasksEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
  }) {
    return _then(_$TasksStartedImpl(
      null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TasksStartedImpl implements TasksStarted {
  const _$TasksStartedImpl(this.projectId);

  @override
  final String projectId;

  @override
  String toString() {
    return 'TasksEvent.started(projectId: $projectId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasksStartedImpl &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, projectId);

  /// Create a copy of TasksEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TasksStartedImplCopyWith<_$TasksStartedImpl> get copyWith =>
      __$$TasksStartedImplCopyWithImpl<_$TasksStartedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String projectId) started,
    required TResult Function(TaskEntity task) createTask,
    required TResult Function(TaskEntity task) updateTask,
    required TResult Function(String projectId, String taskId) deleteTask,
    required TResult Function(TaskStatus filter) filterChanged,
  }) {
    return started(projectId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String projectId)? started,
    TResult? Function(TaskEntity task)? createTask,
    TResult? Function(TaskEntity task)? updateTask,
    TResult? Function(String projectId, String taskId)? deleteTask,
    TResult? Function(TaskStatus filter)? filterChanged,
  }) {
    return started?.call(projectId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String projectId)? started,
    TResult Function(TaskEntity task)? createTask,
    TResult Function(TaskEntity task)? updateTask,
    TResult Function(String projectId, String taskId)? deleteTask,
    TResult Function(TaskStatus filter)? filterChanged,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(projectId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TasksStarted value) started,
    required TResult Function(TasksCreateTask value) createTask,
    required TResult Function(TasksUpdateTask value) updateTask,
    required TResult Function(TasksDeleteTask value) deleteTask,
    required TResult Function(TasksFilterChanged value) filterChanged,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TasksStarted value)? started,
    TResult? Function(TasksCreateTask value)? createTask,
    TResult? Function(TasksUpdateTask value)? updateTask,
    TResult? Function(TasksDeleteTask value)? deleteTask,
    TResult? Function(TasksFilterChanged value)? filterChanged,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TasksStarted value)? started,
    TResult Function(TasksCreateTask value)? createTask,
    TResult Function(TasksUpdateTask value)? updateTask,
    TResult Function(TasksDeleteTask value)? deleteTask,
    TResult Function(TasksFilterChanged value)? filterChanged,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class TasksStarted implements TasksEvent {
  const factory TasksStarted(final String projectId) = _$TasksStartedImpl;

  String get projectId;

  /// Create a copy of TasksEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TasksStartedImplCopyWith<_$TasksStartedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TasksCreateTaskImplCopyWith<$Res> {
  factory _$$TasksCreateTaskImplCopyWith(_$TasksCreateTaskImpl value,
          $Res Function(_$TasksCreateTaskImpl) then) =
      __$$TasksCreateTaskImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TaskEntity task});
}

/// @nodoc
class __$$TasksCreateTaskImplCopyWithImpl<$Res>
    extends _$TasksEventCopyWithImpl<$Res, _$TasksCreateTaskImpl>
    implements _$$TasksCreateTaskImplCopyWith<$Res> {
  __$$TasksCreateTaskImplCopyWithImpl(
      _$TasksCreateTaskImpl _value, $Res Function(_$TasksCreateTaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of TasksEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
  }) {
    return _then(_$TasksCreateTaskImpl(
      null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskEntity,
    ));
  }
}

/// @nodoc

class _$TasksCreateTaskImpl implements TasksCreateTask {
  const _$TasksCreateTaskImpl(this.task);

  @override
  final TaskEntity task;

  @override
  String toString() {
    return 'TasksEvent.createTask(task: $task)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasksCreateTaskImpl &&
            (identical(other.task, task) || other.task == task));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task);

  /// Create a copy of TasksEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TasksCreateTaskImplCopyWith<_$TasksCreateTaskImpl> get copyWith =>
      __$$TasksCreateTaskImplCopyWithImpl<_$TasksCreateTaskImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String projectId) started,
    required TResult Function(TaskEntity task) createTask,
    required TResult Function(TaskEntity task) updateTask,
    required TResult Function(String projectId, String taskId) deleteTask,
    required TResult Function(TaskStatus filter) filterChanged,
  }) {
    return createTask(task);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String projectId)? started,
    TResult? Function(TaskEntity task)? createTask,
    TResult? Function(TaskEntity task)? updateTask,
    TResult? Function(String projectId, String taskId)? deleteTask,
    TResult? Function(TaskStatus filter)? filterChanged,
  }) {
    return createTask?.call(task);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String projectId)? started,
    TResult Function(TaskEntity task)? createTask,
    TResult Function(TaskEntity task)? updateTask,
    TResult Function(String projectId, String taskId)? deleteTask,
    TResult Function(TaskStatus filter)? filterChanged,
    required TResult orElse(),
  }) {
    if (createTask != null) {
      return createTask(task);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TasksStarted value) started,
    required TResult Function(TasksCreateTask value) createTask,
    required TResult Function(TasksUpdateTask value) updateTask,
    required TResult Function(TasksDeleteTask value) deleteTask,
    required TResult Function(TasksFilterChanged value) filterChanged,
  }) {
    return createTask(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TasksStarted value)? started,
    TResult? Function(TasksCreateTask value)? createTask,
    TResult? Function(TasksUpdateTask value)? updateTask,
    TResult? Function(TasksDeleteTask value)? deleteTask,
    TResult? Function(TasksFilterChanged value)? filterChanged,
  }) {
    return createTask?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TasksStarted value)? started,
    TResult Function(TasksCreateTask value)? createTask,
    TResult Function(TasksUpdateTask value)? updateTask,
    TResult Function(TasksDeleteTask value)? deleteTask,
    TResult Function(TasksFilterChanged value)? filterChanged,
    required TResult orElse(),
  }) {
    if (createTask != null) {
      return createTask(this);
    }
    return orElse();
  }
}

abstract class TasksCreateTask implements TasksEvent {
  const factory TasksCreateTask(final TaskEntity task) = _$TasksCreateTaskImpl;

  TaskEntity get task;

  /// Create a copy of TasksEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TasksCreateTaskImplCopyWith<_$TasksCreateTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TasksUpdateTaskImplCopyWith<$Res> {
  factory _$$TasksUpdateTaskImplCopyWith(_$TasksUpdateTaskImpl value,
          $Res Function(_$TasksUpdateTaskImpl) then) =
      __$$TasksUpdateTaskImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TaskEntity task});
}

/// @nodoc
class __$$TasksUpdateTaskImplCopyWithImpl<$Res>
    extends _$TasksEventCopyWithImpl<$Res, _$TasksUpdateTaskImpl>
    implements _$$TasksUpdateTaskImplCopyWith<$Res> {
  __$$TasksUpdateTaskImplCopyWithImpl(
      _$TasksUpdateTaskImpl _value, $Res Function(_$TasksUpdateTaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of TasksEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
  }) {
    return _then(_$TasksUpdateTaskImpl(
      null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskEntity,
    ));
  }
}

/// @nodoc

class _$TasksUpdateTaskImpl implements TasksUpdateTask {
  const _$TasksUpdateTaskImpl(this.task);

  @override
  final TaskEntity task;

  @override
  String toString() {
    return 'TasksEvent.updateTask(task: $task)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasksUpdateTaskImpl &&
            (identical(other.task, task) || other.task == task));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task);

  /// Create a copy of TasksEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TasksUpdateTaskImplCopyWith<_$TasksUpdateTaskImpl> get copyWith =>
      __$$TasksUpdateTaskImplCopyWithImpl<_$TasksUpdateTaskImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String projectId) started,
    required TResult Function(TaskEntity task) createTask,
    required TResult Function(TaskEntity task) updateTask,
    required TResult Function(String projectId, String taskId) deleteTask,
    required TResult Function(TaskStatus filter) filterChanged,
  }) {
    return updateTask(task);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String projectId)? started,
    TResult? Function(TaskEntity task)? createTask,
    TResult? Function(TaskEntity task)? updateTask,
    TResult? Function(String projectId, String taskId)? deleteTask,
    TResult? Function(TaskStatus filter)? filterChanged,
  }) {
    return updateTask?.call(task);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String projectId)? started,
    TResult Function(TaskEntity task)? createTask,
    TResult Function(TaskEntity task)? updateTask,
    TResult Function(String projectId, String taskId)? deleteTask,
    TResult Function(TaskStatus filter)? filterChanged,
    required TResult orElse(),
  }) {
    if (updateTask != null) {
      return updateTask(task);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TasksStarted value) started,
    required TResult Function(TasksCreateTask value) createTask,
    required TResult Function(TasksUpdateTask value) updateTask,
    required TResult Function(TasksDeleteTask value) deleteTask,
    required TResult Function(TasksFilterChanged value) filterChanged,
  }) {
    return updateTask(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TasksStarted value)? started,
    TResult? Function(TasksCreateTask value)? createTask,
    TResult? Function(TasksUpdateTask value)? updateTask,
    TResult? Function(TasksDeleteTask value)? deleteTask,
    TResult? Function(TasksFilterChanged value)? filterChanged,
  }) {
    return updateTask?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TasksStarted value)? started,
    TResult Function(TasksCreateTask value)? createTask,
    TResult Function(TasksUpdateTask value)? updateTask,
    TResult Function(TasksDeleteTask value)? deleteTask,
    TResult Function(TasksFilterChanged value)? filterChanged,
    required TResult orElse(),
  }) {
    if (updateTask != null) {
      return updateTask(this);
    }
    return orElse();
  }
}

abstract class TasksUpdateTask implements TasksEvent {
  const factory TasksUpdateTask(final TaskEntity task) = _$TasksUpdateTaskImpl;

  TaskEntity get task;

  /// Create a copy of TasksEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TasksUpdateTaskImplCopyWith<_$TasksUpdateTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TasksDeleteTaskImplCopyWith<$Res> {
  factory _$$TasksDeleteTaskImplCopyWith(_$TasksDeleteTaskImpl value,
          $Res Function(_$TasksDeleteTaskImpl) then) =
      __$$TasksDeleteTaskImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String projectId, String taskId});
}

/// @nodoc
class __$$TasksDeleteTaskImplCopyWithImpl<$Res>
    extends _$TasksEventCopyWithImpl<$Res, _$TasksDeleteTaskImpl>
    implements _$$TasksDeleteTaskImplCopyWith<$Res> {
  __$$TasksDeleteTaskImplCopyWithImpl(
      _$TasksDeleteTaskImpl _value, $Res Function(_$TasksDeleteTaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of TasksEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? taskId = null,
  }) {
    return _then(_$TasksDeleteTaskImpl(
      null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TasksDeleteTaskImpl implements TasksDeleteTask {
  const _$TasksDeleteTaskImpl(this.projectId, this.taskId);

  @override
  final String projectId;
  @override
  final String taskId;

  @override
  String toString() {
    return 'TasksEvent.deleteTask(projectId: $projectId, taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasksDeleteTaskImpl &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, projectId, taskId);

  /// Create a copy of TasksEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TasksDeleteTaskImplCopyWith<_$TasksDeleteTaskImpl> get copyWith =>
      __$$TasksDeleteTaskImplCopyWithImpl<_$TasksDeleteTaskImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String projectId) started,
    required TResult Function(TaskEntity task) createTask,
    required TResult Function(TaskEntity task) updateTask,
    required TResult Function(String projectId, String taskId) deleteTask,
    required TResult Function(TaskStatus filter) filterChanged,
  }) {
    return deleteTask(projectId, taskId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String projectId)? started,
    TResult? Function(TaskEntity task)? createTask,
    TResult? Function(TaskEntity task)? updateTask,
    TResult? Function(String projectId, String taskId)? deleteTask,
    TResult? Function(TaskStatus filter)? filterChanged,
  }) {
    return deleteTask?.call(projectId, taskId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String projectId)? started,
    TResult Function(TaskEntity task)? createTask,
    TResult Function(TaskEntity task)? updateTask,
    TResult Function(String projectId, String taskId)? deleteTask,
    TResult Function(TaskStatus filter)? filterChanged,
    required TResult orElse(),
  }) {
    if (deleteTask != null) {
      return deleteTask(projectId, taskId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TasksStarted value) started,
    required TResult Function(TasksCreateTask value) createTask,
    required TResult Function(TasksUpdateTask value) updateTask,
    required TResult Function(TasksDeleteTask value) deleteTask,
    required TResult Function(TasksFilterChanged value) filterChanged,
  }) {
    return deleteTask(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TasksStarted value)? started,
    TResult? Function(TasksCreateTask value)? createTask,
    TResult? Function(TasksUpdateTask value)? updateTask,
    TResult? Function(TasksDeleteTask value)? deleteTask,
    TResult? Function(TasksFilterChanged value)? filterChanged,
  }) {
    return deleteTask?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TasksStarted value)? started,
    TResult Function(TasksCreateTask value)? createTask,
    TResult Function(TasksUpdateTask value)? updateTask,
    TResult Function(TasksDeleteTask value)? deleteTask,
    TResult Function(TasksFilterChanged value)? filterChanged,
    required TResult orElse(),
  }) {
    if (deleteTask != null) {
      return deleteTask(this);
    }
    return orElse();
  }
}

abstract class TasksDeleteTask implements TasksEvent {
  const factory TasksDeleteTask(final String projectId, final String taskId) =
      _$TasksDeleteTaskImpl;

  String get projectId;
  String get taskId;

  /// Create a copy of TasksEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TasksDeleteTaskImplCopyWith<_$TasksDeleteTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TasksFilterChangedImplCopyWith<$Res> {
  factory _$$TasksFilterChangedImplCopyWith(_$TasksFilterChangedImpl value,
          $Res Function(_$TasksFilterChangedImpl) then) =
      __$$TasksFilterChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TaskStatus filter});
}

/// @nodoc
class __$$TasksFilterChangedImplCopyWithImpl<$Res>
    extends _$TasksEventCopyWithImpl<$Res, _$TasksFilterChangedImpl>
    implements _$$TasksFilterChangedImplCopyWith<$Res> {
  __$$TasksFilterChangedImplCopyWithImpl(_$TasksFilterChangedImpl _value,
      $Res Function(_$TasksFilterChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TasksEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filter = null,
  }) {
    return _then(_$TasksFilterChangedImpl(
      null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
    ));
  }
}

/// @nodoc

class _$TasksFilterChangedImpl implements TasksFilterChanged {
  const _$TasksFilterChangedImpl(this.filter);

  @override
  final TaskStatus filter;

  @override
  String toString() {
    return 'TasksEvent.filterChanged(filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasksFilterChangedImpl &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filter);

  /// Create a copy of TasksEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TasksFilterChangedImplCopyWith<_$TasksFilterChangedImpl> get copyWith =>
      __$$TasksFilterChangedImplCopyWithImpl<_$TasksFilterChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String projectId) started,
    required TResult Function(TaskEntity task) createTask,
    required TResult Function(TaskEntity task) updateTask,
    required TResult Function(String projectId, String taskId) deleteTask,
    required TResult Function(TaskStatus filter) filterChanged,
  }) {
    return filterChanged(filter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String projectId)? started,
    TResult? Function(TaskEntity task)? createTask,
    TResult? Function(TaskEntity task)? updateTask,
    TResult? Function(String projectId, String taskId)? deleteTask,
    TResult? Function(TaskStatus filter)? filterChanged,
  }) {
    return filterChanged?.call(filter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String projectId)? started,
    TResult Function(TaskEntity task)? createTask,
    TResult Function(TaskEntity task)? updateTask,
    TResult Function(String projectId, String taskId)? deleteTask,
    TResult Function(TaskStatus filter)? filterChanged,
    required TResult orElse(),
  }) {
    if (filterChanged != null) {
      return filterChanged(filter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TasksStarted value) started,
    required TResult Function(TasksCreateTask value) createTask,
    required TResult Function(TasksUpdateTask value) updateTask,
    required TResult Function(TasksDeleteTask value) deleteTask,
    required TResult Function(TasksFilterChanged value) filterChanged,
  }) {
    return filterChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TasksStarted value)? started,
    TResult? Function(TasksCreateTask value)? createTask,
    TResult? Function(TasksUpdateTask value)? updateTask,
    TResult? Function(TasksDeleteTask value)? deleteTask,
    TResult? Function(TasksFilterChanged value)? filterChanged,
  }) {
    return filterChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TasksStarted value)? started,
    TResult Function(TasksCreateTask value)? createTask,
    TResult Function(TasksUpdateTask value)? updateTask,
    TResult Function(TasksDeleteTask value)? deleteTask,
    TResult Function(TasksFilterChanged value)? filterChanged,
    required TResult orElse(),
  }) {
    if (filterChanged != null) {
      return filterChanged(this);
    }
    return orElse();
  }
}

abstract class TasksFilterChanged implements TasksEvent {
  const factory TasksFilterChanged(final TaskStatus filter) =
      _$TasksFilterChangedImpl;

  TaskStatus get filter;

  /// Create a copy of TasksEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TasksFilterChangedImplCopyWith<_$TasksFilterChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
