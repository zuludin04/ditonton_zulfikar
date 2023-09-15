import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'movie_recommendations_state.dart';

class MovieRecommendationsCubit extends Cubit<MovieRecommendationsState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationsCubit({required this.getMovieRecommendations})
      : super(MovieRecommendationsInitial());

  Future<void> fetchMovieRecommendations(int id) async {
    emit(MovieRecommendationsLoading());

    var recommendationResult = await getMovieRecommendations.execute(id);
    recommendationResult.fold(
      (failure) {
        emit(MovieRecommendationsError(message: failure.message));
      },
      (movies) {
        emit(MovieRecommendationsHasData(movies: movies));
      },
    );
  }
}
