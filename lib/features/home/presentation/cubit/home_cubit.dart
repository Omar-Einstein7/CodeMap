import 'package:flutter_bloc/flutter_bloc.dart';
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

  void loadHomeData() {
    emit(HomeLoading());
    try {
      // Simulate data loading
      emit(HomeLoaded(
        selectedCategoryIndex: 0,
        categories: categories,
        featuredCourses: featuredCourses,
        featuredImages: featuredImages,
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
      ));
    }
  }
}
