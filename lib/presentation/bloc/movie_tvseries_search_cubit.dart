import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/search_result.dart';
import 'package:ditonton/domain/usecases/search_movies_tvseries.dart';
import 'package:equatable/equatable.dart';

part 'movie_tvseries_search_state.dart';

class MovieTvSeriesSearchCubit extends Cubit<MovieTvSeriesSearchState> {
  final SearchMoviesTvSeries searchMovies;

  MovieTvSeriesSearchCubit({required this.searchMovies}) : super(SearchEmpty());

  Future<void> onQueryChanged(bool searchMovie, String query) async {
    emit(SearchLoading());

    final result = await searchMovies.execute(searchMovie, query);

    result.fold(
      (failure) {
        emit(SearchError(message: failure.message));
      },
      (data) {
        emit(SearchHasData(result: data));
      },
    );
  }
}
