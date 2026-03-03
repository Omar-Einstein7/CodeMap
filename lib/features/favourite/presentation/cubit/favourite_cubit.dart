import 'package:codemap2/features/course/domain/entities/course.dart';
import 'package:codemap2/features/favourite/domain/repositories/favourite_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FavouriteRepository _repository;

  FavouriteCubit(this._repository) : super(FavouriteInitial());

  Future<void> loadFavourites() async {
    emit(FavouriteLoading());
    try {
      final favourites = await _repository.getFavourites();
      emit(FavouriteLoaded(favourites));
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  Future<void> toggleFavourite(Course course) async {
    try {
      final isFav = await _repository.isFavourite(course.id);
      if (isFav) {
        await _repository.removeFavourite(course.id);
      } else {
        await _repository.addFavourite(course);
      }
      final updatedFavourites = await _repository.getFavourites();
      emit(FavouriteLoaded(updatedFavourites));
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }
}
