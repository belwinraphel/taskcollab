import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

class CreateNotification implements UseCase<void, CreateNotificationParams> {
  final NotificationRepository repository;

  CreateNotification(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateNotificationParams params) async {
    return await repository.createNotification(params.notification);
  }
}

class CreateNotificationParams extends Equatable {
  final NotificationEntity notification;

  const CreateNotificationParams({required this.notification});

  @override
  List<Object> get props => [notification];
}
