import '../repositories/auth_repository.dart';
import '../entities/user.dart';

class GetAuthStream {
  final AuthRepository repository;

  GetAuthStream(this.repository);

  Stream<UserEntity?> call() {
    return repository.authUserStream;
  }
}
