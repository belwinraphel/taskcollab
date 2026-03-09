import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/project.dart';

abstract class ProjectRepository {
  Future<Either<Failure, Stream<List<Project>>>> getProjects({int limit = 50});
  Future<Either<Failure, Project>> createProject(
      String name, String description);
  Future<Either<Failure, void>> updateProject(Project project);
  Future<Either<Failure, void>> deleteProject(String projectId);
}
