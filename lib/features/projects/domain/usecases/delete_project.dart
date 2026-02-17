import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/project_repository.dart';

class DeleteProject implements UseCase<void, String> {
  final ProjectRepository repository;

  DeleteProject(this.repository);

  @override
  Future<Either<Failure, void>> call(String projectId) async {
    return await repository.deleteProject(projectId);
  }
}
