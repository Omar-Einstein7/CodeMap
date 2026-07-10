import 'package:equatable/equatable.dart';

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

  const HomeLoaded({
    required this.selectedCategoryIndex,
    required this.categories,
    required this.featuredCourses,
    required this.featuredImages,
  });

  @override
  List<Object?> get props => [
        selectedCategoryIndex,
        categories,
        featuredCourses,
        featuredImages,
      ];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
