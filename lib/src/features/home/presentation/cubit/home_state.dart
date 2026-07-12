import 'package:equatable/equatable.dart';
import 'package:codemap2/src/features/course/domain/entities/course.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final int selectedCategoryIndex;
  final List<String> categories;
  final List<String> featuredCourses;
  final List<String> featuredImages;
  final List<Course> featuredCourseData;

  const HomeLoaded({
    required this.selectedCategoryIndex,
    required this.categories,
    required this.featuredCourses,
    required this.featuredImages,
    required this.featuredCourseData,
  });

  @override
  List<Object?> get props => [
        selectedCategoryIndex,
        categories,
        featuredCourses,
        featuredImages,
        featuredCourseData,
      ];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
