import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/project.dart';
import '../repositories/project_repository.dart';

class GetProjects implements UseCase<Stream<List<Project>>, NoParams> {
  final ProjectRepository repository;

  GetProjects(this.repository);

  @override
  Future<Either<Failure, Stream<List<Project>>>> call(NoParams params) async {
    return await repository.getProjects();
  }
}
