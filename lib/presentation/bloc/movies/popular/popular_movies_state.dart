part of 'popular_movies_cubit.dart';

enum PopularMoviesStatus { loading, error, hasData }

final class PopularMoviesState extends Equatable {
  final List<Movie> movies;
  final String message;
  final PopularMoviesStatus status;

  const PopularMoviesState._({
    this.status = PopularMoviesStatus.loading,
    this.movies = const <Movie>[],
    this.message = "",
  });

  const PopularMoviesState.loading() : this._();

  const PopularMoviesState.hasData(List<Movie> movies)
      : this._(status: PopularMoviesStatus.hasData, movies: movies);

  const PopularMoviesState.error(String message)
      : this._(status: PopularMoviesStatus.error, message: message);

  @override
  List<Object> get props => [];
}

