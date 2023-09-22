import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesCubit({required this.getPopularMovies})
      : super(const PopularMoviesState.loading());

  Future<void> fetchPopularMovies() async {
    var result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        emit(PopularMoviesState.error(failure.message));
      },
      (moviesData) {
        emit(PopularMoviesState.hasData(moviesData));
      },
    );
  }
}
