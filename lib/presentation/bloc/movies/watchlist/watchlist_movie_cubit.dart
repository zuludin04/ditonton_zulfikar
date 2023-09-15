import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_state.dart';

class WatchlistMovieCubit extends Cubit<WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieCubit({required this.getWatchlistMovies})
      : super(WatchlistMovieInitial());

  Future<void> fetchWatchlistMovies() async {
    emit(WatchlistMovieLoading());

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        emit(WatchlistMovieError(message: failure.message));
      },
      (moviesData) {
        emit(WatchlistMovieHasData(movies: moviesData));
      },
    );
  }
}
