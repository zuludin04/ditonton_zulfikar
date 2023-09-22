part of 'movie_recommendations_cubit.dart';

enum MovieRecommendationsStatus { loading, error, empty, hasData }

final class MovieRecommendationsState extends Equatable {
  final List<Movie> movies;
  final String message;
  final MovieRecommendationsStatus status;

  const MovieRecommendationsState._({
    this.movies = const <Movie>[],
    this.message = "",
    this.status = MovieRecommendationsStatus.loading,
  });

  const MovieRecommendationsState.loading() : this._();

  const MovieRecommendationsState.empty()
      : this._(status: MovieRecommendationsStatus.empty);

  const MovieRecommendationsState.error(String message)
      : this._(message: message, status: MovieRecommendationsStatus.error);

  const MovieRecommendationsState.hasData(List<Movie> movies)
      : this._(movies: movies, status: MovieRecommendationsStatus.hasData);

  @override
  List<Object> get props => [];
}
