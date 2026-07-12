import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codemap2/src/features/course/domain/entities/course.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final List<String> categories = [
    "Recent",
    "mobile",
    "fornt end",
    "back end",
    "AI",
    "games",
  ];

  final List<String> featuredImages = [
    "images2/c#.png",
    "images2/C++.png",
    "images2/css.png",
    "images2/html-5.png",
    "images2/5Java.png",
    "images2/6Javascript.png",
    "images2/7Python.png",
  ];

  final List<String> featuredCourses = [
    "C #",
    "C + +",
    "C s s",
    "H T M L",
    "J a v a",
    "Java Script",
    "P y t h o n",
  ];

  final List<Course> featuredCourseData = [
    Course(id: '1', name: 'C#', imageUrl: 'images2/c#.png', category: CourseCategory.mobile),
    Course(id: '2', name: 'C++', imageUrl: 'images2/C++.png', category: CourseCategory.mobile),
    Course(id: '3', name: 'CSS', imageUrl: 'images2/css.png', category: CourseCategory.frontend),
    Course(id: '4', name: 'HTML', imageUrl: 'images2/html-5.png', category: CourseCategory.frontend),
    Course(id: '5', name: 'Java', imageUrl: 'images2/5Java.png', category: CourseCategory.backend),
    Course(id: '6', name: 'JavaScript', imageUrl: 'images2/6Javascript.png', category: CourseCategory.backend),
    Course(id: '7', name: 'Python', imageUrl: 'images2/7Python.png', category: CourseCategory.ai),
  ];

  void loadHomeData() {
    emit(HomeLoading());
    try {
      // Simulate data loading
      emit(HomeLoaded(
        selectedCategoryIndex: 0,
        categories: categories,
        featuredCourses: featuredCourses,
        featuredImages: featuredImages,
        featuredCourseData: featuredCourseData,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void selectCategory(int index) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(HomeLoaded(
        selectedCategoryIndex: index,
        categories: currentState.categories,
        featuredCourses: currentState.featuredCourses,
        featuredImages: currentState.featuredImages,
        featuredCourseData: currentState.featuredCourseData,
      ));
    }
  }
}
