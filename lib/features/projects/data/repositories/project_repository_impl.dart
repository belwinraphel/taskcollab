import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/auth_failure.dart';
import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';
import '../datasources/project_remote_data_source.dart';
import '../models/project_model.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;
  final FirebaseAuth firebaseAuth;

  ProjectRepositoryImpl(this.remoteDataSource, this.firebaseAuth);

  @override
  Future<Either<Failure, Stream<List<Project>>>> getProjects(
      {int limit = 50}) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) return const Left(AuthFailure.sessionExpired());

      final projectStream =
          remoteDataSource.getProjects(user.uid, limit: limit);
      return Right(projectStream.map((models) => models
          .map((model) => Project(
                id: model.id,
                name: model.name,
                description: model.description,
                ownerId: model.ownerId,
                memberIds: model.memberIds,
                createdAt: model.createdAt,
              ))
          .toList()));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Project>> createProject(
      String name, String description) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) return const Left(AuthFailure.sessionExpired());

      final project =
          await remoteDataSource.createProject(name, description, user.uid);
      return Right(project);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProject(Project project) async {
    try {
      // Need to cast to ProjectModel or create a new one
      final projectModel = ProjectModel(
        id: project.id,
        name: project.name,
        description: project.description,
        ownerId: project.ownerId,
        memberIds: project.memberIds,
        createdAt: project.createdAt,
      );
      await remoteDataSource.updateProject(projectModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(String projectId) async {
    try {
      await remoteDataSource.deleteProject(projectId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
