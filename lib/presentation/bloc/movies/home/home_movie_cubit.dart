import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'home_movie_state.dart';

class HomeMovieCubit extends Cubit<HomeMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  HomeMovieCubit({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(HomeMovieInitial());

  Future<void> fetchNowPlayingMovies() async {
    emit(HomeMovieNowPlayingLoading());

    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        emit(HomeMovieNowPlayingError(message: failure.message));
      },
      (moviesData) {
        emit(HomeMovieNowPlayingHasData(movies: moviesData));
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    emit(HomeMoviePopularLoading());

    final result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        emit(HomeMoviePopularError(message: failure.message));
      },
      (moviesData) {
        emit(HomeMoviePopularHasData(movies: moviesData));
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    emit(HomeMovieTopRatedLoading());

    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        emit(HomeMovieTopRatedError(message: failure.message));
      },
      (moviesData) {
        emit(HomeMovieTopRatedHasData(movies: moviesData));
      },
    );
  }
}
