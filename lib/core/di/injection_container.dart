import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/local_notification_service.dart';
import '../services/push_notification_service.dart';
import '../services/task_notification_listener.dart';
import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_current_user.dart';
import '../../features/auth/domain/usecases/get_auth_stream.dart';
import '../../features/auth/domain/usecases/login_user.dart';
import '../../features/auth/domain/usecases/logout_user.dart';
import '../../features/auth/domain/usecases/register_user.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/projects/data/datasources/project_remote_data_source.dart';
import '../../features/projects/data/repositories/project_repository_impl.dart';
import '../../features/projects/domain/repositories/project_repository.dart';
import '../../features/projects/domain/usecases/create_project.dart';
import '../../features/projects/domain/usecases/delete_project.dart';
import '../../features/projects/domain/usecases/get_projects.dart';
import '../../features/projects/domain/usecases/update_project.dart';
import '../../features/projects/presentation/bloc/projects_bloc.dart';
import '../../features/tasks/data/datasources/task_remote_data_source.dart';
import '../../features/tasks/data/repositories/task_repository_impl.dart';
import '../../features/tasks/domain/repositories/task_repository.dart';
import '../../features/tasks/domain/usecases/create_task.dart';
import '../../features/tasks/domain/usecases/delete_task.dart';
import '../../features/tasks/domain/usecases/get_tasks.dart';
import '../../features/tasks/domain/usecases/update_task.dart';
import '../../features/tasks/presentation/bloc/tasks_bloc.dart';
import '../../features/users/data/datasources/user_remote_data_source.dart';
import '../../features/users/data/repositories/user_repository_impl.dart';
import '../../features/users/domain/repositories/user_repository.dart';
import '../../features/users/presentation/bloc/users_bloc.dart';
import '../../features/profile/data/datasources/profile_remote_data_source.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/get_profile.dart';
import '../../features/profile/domain/usecases/update_profile.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/notifications/data/datasources/notification_remote_data_source.dart';
import '../../features/notifications/data/repositories/notification_repository_impl.dart';
import '../../features/notifications/domain/repositories/notification_repository.dart';
import '../../features/notifications/domain/usecases/get_notifications.dart';
import '../../features/notifications/domain/usecases/mark_notification_as_read.dart';
import '../../features/notifications/domain/usecases/create_notification.dart';
import '../../features/notifications/presentation/bloc/notifications_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // External
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => const FlutterSecureStorage());

  // Core
  // ...

  // Features - Auth
  // Data sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(getIt()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => LoginUser(getIt()));
  getIt.registerLazySingleton(() => RegisterUser(getIt()));
  getIt.registerLazySingleton(() => LogoutUser(getIt()));
  getIt.registerLazySingleton(() => GetCurrentUser(getIt()));
  getIt.registerLazySingleton(() => GetAuthStream(getIt()));

  // Bloc
  getIt.registerFactory(
    () => AuthBloc(
      loginUser: getIt(),
      registerUser: getIt(),
      logoutUser: getIt(),
      getCurrentUser: getIt(),
      getAuthStream: getIt(),
    ),
  );

  // Features - Projects
  // Data sources
  getIt.registerLazySingleton<ProjectRemoteDataSource>(
    () => ProjectRemoteDataSourceImpl(getIt()),
  );
  // Repository
  getIt.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(getIt(), getIt()),
  );
  // Use cases
  getIt.registerLazySingleton(() => GetProjects(getIt()));
  getIt.registerLazySingleton(() => CreateProject(getIt()));
  getIt.registerLazySingleton(() => UpdateProject(getIt()));
  getIt.registerLazySingleton(() => DeleteProject(getIt()));
  // Bloc
  getIt.registerFactory(
    () => ProjectsBloc(
      getProjects: getIt(),
      createProject: getIt(),
      updateProject: getIt(),
      deleteProject: getIt(),
    ),
  );

  // Features - Users
  // Data sources
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(getIt()),
  );
  // Repository
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt()),
  );
  // Bloc
  getIt.registerFactory(
    () => UsersBloc(userRepository: getIt()),
  );

  // Features - Profile
  // Data sources
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(getIt()),
  );
  // Repository
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt()),
  );
  // Use cases
  getIt.registerLazySingleton(() => GetProfile(getIt()));
  getIt.registerLazySingleton(() => UpdateProfile(getIt()));
  // Bloc
  getIt.registerFactory(
    () => ProfileBloc(
      getProfile: getIt(),
      updateProfile: getIt(),
    ),
  );

  // Features - Notifications
  // Data sources
  getIt.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(getIt()),
  );
  // Repository
  getIt.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(getIt()),
  );
  // Use cases
  getIt.registerLazySingleton(() => GetNotifications(getIt()));
  getIt.registerLazySingleton(() => MarkNotificationAsRead(getIt()));
  getIt.registerLazySingleton(() => CreateNotification(getIt()));
  // Bloc
  getIt.registerFactory(
    () => NotificationsBloc(
      getNotifications: getIt(),
      markNotificationAsRead: getIt(),
    ),
  );

  // Features - Tasks
  // ...
  // Core Services
  getIt.registerLazySingleton<LocalNotificationService>(
    () => LocalNotificationService(),
  );
  getIt.registerLazySingleton<PushNotificationService>(
    () => PushNotificationService(authRepository: getIt()),
  );
  getIt.registerLazySingleton<TaskNotificationListener>(
    () => TaskNotificationListener(
      remoteDataSource: getIt(),
      localNotificationService: getIt(),
      firebaseAuth: getIt(),
    ),
  );

  // Data sources
  getIt.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(getIt()),
  );
  // Repository
  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(getIt()),
  );
  // Use cases
  getIt.registerLazySingleton(() => GetTasks(getIt()));
  getIt.registerLazySingleton(() => CreateTask(getIt()));
  getIt.registerLazySingleton(() => UpdateTask(getIt()));
  getIt.registerLazySingleton(() => DeleteTask(getIt()));
  // Bloc
  getIt.registerFactory(
    () => TasksBloc(
      getTasks: getIt(),
      createTask: getIt(),
      updateTask: getIt(),
      deleteTask: getIt(),
      taskNotificationListener: getIt(),
      createNotification: getIt(),
    ),
  );
}
