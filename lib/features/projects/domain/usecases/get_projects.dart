import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/project.dart';
import '../repositories/project_repository.dart';

class GetProjectsParams {
  final int limit;
  GetProjectsParams({this.limit = 50});
}

class GetProjects implements UseCase<Stream<List<Project>>, GetProjectsParams> {
  final ProjectRepository repository;

  GetProjects(this.repository);

  @override
  Future<Either<Failure, Stream<List<Project>>>> call(
      GetProjectsParams params) async {
    return await repository.getProjects(limit: params.limit);
  }
}
