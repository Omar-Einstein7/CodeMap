
import 'package:codemap2/features/course/domain/entities/course.dart';

abstract class FavouriteRepository {
  Future<List<Course>> getFavourites();
  Future<void> addFavourite(Course course);
  Future<void> removeFavourite(String courseId);
  Future<bool> isFavourite(String courseId);
}
