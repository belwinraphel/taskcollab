import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

class GetNotifications {
  final NotificationRepository repository;

  GetNotifications(this.repository);

  Stream<List<NotificationEntity>> call(String userId) {
    return repository.getNotifications(userId);
  }
}
