import 'package:codemap2/features/course/domain/entities/course.dart';


import '../../domain/repositories/favourite_repository.dart';

class LocalFavouriteRepository implements FavouriteRepository {
  final List<Course> _favourites = [];

  @override
  Future<List<Course>> getFavourites() async {
    return List.from(_favourites);
  }

  @override
  Future<void> addFavourite(Course course) async {
    if (!_favourites.any((c) => c.id == course.id)) {
      _favourites.add(course);
    }
  }

  @override
  Future<void> removeFavourite(String courseId) async {
    _favourites.removeWhere((c) => c.id == courseId);
  }

  @override
  Future<bool> isFavourite(String courseId) async {
    return _favourites.any((c) => c.id == courseId);
  }
}
