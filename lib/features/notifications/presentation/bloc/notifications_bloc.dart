import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_notifications.dart';
import '../../domain/usecases/mark_notification_as_read.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';
import '../../domain/entities/notification.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotifications getNotifications;
  final MarkNotificationAsRead markNotificationAsRead;
  StreamSubscription? _notificationsSubscription;

  NotificationsBloc({
    required this.getNotifications,
    required this.markNotificationAsRead,
  }) : super(NotificationsInitial()) {
    on<NotificationsLoadRequested>(_onLoadRequested);
    on<NotificationMarkAsRead>(_onMarkAsRead);
    on<NotificationsUpdated>(_onNotificationsUpdated);
    on<NotificationsErrorEvent>(_onNotificationsError);
  }

  Future<void> _onLoadRequested(NotificationsLoadRequested event,
      Emitter<NotificationsState> emit) async {
    emit(NotificationsLoading());
    await _notificationsSubscription?.cancel();
    _notificationsSubscription = getNotifications(event.userId).listen(
      (notifications) => add(NotificationsUpdated(notifications)),
      onError: (error) => add(NotificationsErrorEvent(error.toString())),
    );
  }

  void _onNotificationsUpdated(
      NotificationsUpdated event, Emitter<NotificationsState> emit) {
    emit(NotificationsLoaded(event.notifications));
  }

  void _onNotificationsError(
      NotificationsErrorEvent event, Emitter<NotificationsState> emit) {
    emit(NotificationsError(event.message));
  }

  Future<void> _onMarkAsRead(
      NotificationMarkAsRead event, Emitter<NotificationsState> emit) async {
    final result = await markNotificationAsRead(
        MarkNotificationAsReadParams(notificationId: event.notificationId));
    result.fold(
      (failure) {
        // Optionally handle error
      },
      (_) {
        // Success
      },
    );
  }

  @override
  Future<void> close() {
    _notificationsSubscription?.cancel();
    return super.close();
  }
}

// Private events for internal stream updates
class NotificationsUpdated extends NotificationsEvent {
  final List<NotificationEntity> notifications;

  const NotificationsUpdated(this.notifications);

  @override
  List<Object> get props => [notifications];
}

class NotificationsErrorEvent extends NotificationsEvent {
  final String message;

  const NotificationsErrorEvent(this.message);

  @override
  List<Object> get props => [message];
}
