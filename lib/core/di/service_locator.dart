import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/course/data/repositories/local_course_repository.dart';
import '../../features/course/domain/repositories/course_repository.dart';
import '../../features/favourite/data/repositories/local_favourite_repository.dart';
import '../../features/favourite/domain/repositories/favourite_repository.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/profile/data/repositories/local_user_profile_repository.dart';
import '../../features/profile/domain/repositories/user_profile_repository.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/favourite/presentation/cubit/favourite_cubit.dart';
import '../../features/course/presentation/cubit/course_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Auth
  sl.registerFactory(() => AuthCubit());

  // Features - Home
  sl.registerFactory(() => HomeCubit());

  // Features - Course
  sl.registerFactory(() => CourseCubit(sl()));
  sl.registerLazySingleton<CourseRepository>(() => LocalCourseRepository());

  // Features - Profile
  sl.registerFactory(() => ProfileCubit(sl()));
  sl.registerLazySingleton<UserProfileRepository>(() => LocalUserProfileRepository());

  // Features - Favourite
  sl.registerFactory(() => FavouriteCubit(sl()));
  sl.registerLazySingleton<FavouriteRepository>(() => LocalFavouriteRepository());

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
