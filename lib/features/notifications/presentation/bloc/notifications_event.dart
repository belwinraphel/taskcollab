import 'package:equatable/equatable.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class NotificationsLoadRequested extends NotificationsEvent {
  final String userId;

  const NotificationsLoadRequested(this.userId);

  @override
  List<Object> get props => [userId];
}

class NotificationMarkAsRead extends NotificationsEvent {
  final String notificationId;

  const NotificationMarkAsRead(this.notificationId);

  @override
  List<Object> get props => [notificationId];
}

class NotificationCreated extends NotificationsEvent {
  // This might be triggered internally or by other blocs,
  // but usually we listen to the stream.
}
