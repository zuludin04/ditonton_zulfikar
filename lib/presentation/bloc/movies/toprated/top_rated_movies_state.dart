part of 'top_rated_movies_cubit.dart';

enum TopRatedMoviesStatus { loading, error, hasData }

final class TopRatedMoviesState extends Equatable {
  final List<Movie> movies;
  final String message;
  final TopRatedMoviesStatus status;

  const TopRatedMoviesState._({
    this.movies = const <Movie>[],
    this.message = "",
    this.status = TopRatedMoviesStatus.loading,
  });

  const TopRatedMoviesState.loading() : this._();

  const TopRatedMoviesState.hasData(List<Movie> movies)
      : this._(movies: movies, status: TopRatedMoviesStatus.hasData);

  const TopRatedMoviesState.error(String message)
      : this._(message: message, status: TopRatedMoviesStatus.error);

  @override
  List<Object> get props => [];
}
