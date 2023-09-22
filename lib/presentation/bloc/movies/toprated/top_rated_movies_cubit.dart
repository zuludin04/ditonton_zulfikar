import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesCubit({required this.getTopRatedMovies})
      : super(const TopRatedMoviesState.loading());

  Future<void> fetchTopRatedMovies() async {
    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        emit(TopRatedMoviesState.error(failure.message));
      },
      (moviesData) {
        emit(TopRatedMoviesState.hasData(moviesData));
      },
    );
  }
}
