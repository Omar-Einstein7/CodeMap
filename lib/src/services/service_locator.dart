import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codemap2/src/services/dio_client.dart';

import 'package:codemap2/src/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:codemap2/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:codemap2/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:codemap2/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:codemap2/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:codemap2/src/features/course/data/repositories/api_course_repository.dart';
import 'package:codemap2/src/features/course/data/repositories/api_progress_repository.dart';
import 'package:codemap2/src/features/course/domain/repositories/course_repository.dart';
import 'package:codemap2/src/features/course/domain/repositories/progress_repository.dart';
import 'package:codemap2/src/features/favourite/data/repositories/api_favourite_repository.dart';
import 'package:codemap2/src/features/favourite/domain/repositories/favourite_repository.dart';
import 'package:codemap2/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:codemap2/src/theme/theme_cubit.dart';
import 'package:codemap2/src/services/splash_cubit.dart';
import 'package:codemap2/src/features/profile/data/repositories/api_user_profile_repository.dart';
import 'package:codemap2/src/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:codemap2/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:codemap2/src/features/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:codemap2/src/features/course/presentation/cubit/course_cubit.dart';
import 'package:codemap2/src/features/course/presentation/cubit/course_detail_cubit.dart';
import 'package:codemap2/src/features/course/presentation/cubit/lesson_progress_cubit.dart';
import 'package:codemap2/src/services/secure_token_storage.dart';
import 'package:codemap2/src/services/session_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Auth
  sl.registerFactory(() => AuthCubit(sl(), sl()));
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => ApiAuthRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      sharedPreferences: sl(),
      secureTokenStorage: sl(),
    ),
  );

  // Features - Home
  sl.registerFactory(() => HomeCubit(sl()));

  // Features - Course
  sl.registerFactory(() => CourseCubit(sl()));
  sl.registerFactory(() => CourseDetailCubit(sl()));
  sl.registerFactory(() => LessonProgressCubit(sl()));
  sl.registerLazySingleton<CourseRepository>(() => ApiCourseRepository(sl()));
  sl.registerLazySingleton<ProgressRepository>(() => ApiProgressRepository(sl()));

  // Features - Profile
  sl.registerFactory(() => ProfileCubit(sl()));
  sl.registerLazySingleton<UserProfileRepository>(
    () => ApiUserProfileRepository(dioClient: sl(), authLocalDataSource: sl()),
  );

  // Features - Favourite
  sl.registerFactory(() => FavouriteCubit(sl()));
  sl.registerLazySingleton<FavouriteRepository>(
    () => ApiFavouriteRepository(dioClient: sl(), authLocalDataSource: sl()),
  );

  // Core
  sl.registerLazySingleton(() => SecureTokenStorage());
  sl.registerLazySingleton(() => SessionCubit(sl()));
  sl.registerLazySingleton(() => DioClient());

  // Global / DI - Theming & Splash
  sl.registerFactory(() => ThemeCubit());
  sl.registerFactory(() => SplashCubit());

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
