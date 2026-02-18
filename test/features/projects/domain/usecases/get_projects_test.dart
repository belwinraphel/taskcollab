import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_collab_app/core/usecases/usecase.dart';
import 'package:task_collab_app/features/projects/domain/entities/project.dart';
import 'package:task_collab_app/features/projects/domain/repositories/project_repository.dart';
import 'package:task_collab_app/features/projects/domain/usecases/get_projects.dart';

class MockProjectRepository extends Mock implements ProjectRepository {}

void main() {
  late GetProjects usecase;
  late MockProjectRepository mockProjectRepository;

  setUp(() {
    mockProjectRepository = MockProjectRepository();
    usecase = GetProjects(mockProjectRepository);
  });

  // Fix DateTime issue by using a fixed date if needed, but Project entity uses required DateTime.
  // Mocktail needs registerFallbackValue if used in any argumentsmatcher, but here we return it.
  // Let's fix the entity instantiation.
  final tDate = DateTime(2023, 1, 1);
  final tProjectList = [
    Project(
      id: '1',
      name: 'Test Project',
      description: 'Test Description',
      ownerId: 'user1',
      memberIds: const ['user1'],
      createdAt: tDate,
    )
  ];

  test('should get projects from the repository', () async {
    // arrange
    when(() => mockProjectRepository.getProjects())
        .thenAnswer((_) async => Right(Stream.value(tProjectList)));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result.fold((l) => null, (r) => r), emits(tProjectList));
    verify(() => mockProjectRepository.getProjects());
    verifyNoMoreInteractions(mockProjectRepository);
  });
}
