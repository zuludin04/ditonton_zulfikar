part of 'home_movie_cubit.dart';

abstract class HomeMovieState extends Equatable {
  const HomeMovieState();

  @override
  List<Object> get props => [];
}

class HomeMovieInitial extends HomeMovieState {}

class HomeMoviePopularLoading extends HomeMovieState {}

class HomeMoviePopularError extends HomeMovieState {
  final String message;

  const HomeMoviePopularError({required this.message});

  @override
  List<Object> get props => [message];
}

class HomeMoviePopularHasData extends HomeMovieState {
  final List<Movie> movies;

  const HomeMoviePopularHasData({required this.movies});

  @override
  List<Object> get props => [movies];
}

class HomeMovieTopRatedLoading extends HomeMovieState {}

class HomeMovieTopRatedError extends HomeMovieState {
  final String message;

  const HomeMovieTopRatedError({required this.message});

  @override
  List<Object> get props => [message];
}

class HomeMovieTopRatedHasData extends HomeMovieState {
  final List<Movie> movies;

  const HomeMovieTopRatedHasData({required this.movies});

  @override
  List<Object> get props => [movies];
}

class HomeMovieNowPlayingLoading extends HomeMovieState {}

class HomeMovieNowPlayingError extends HomeMovieState {
  final String message;

  const HomeMovieNowPlayingError({required this.message});

  @override
  List<Object> get props => [message];
}

class HomeMovieNowPlayingHasData extends HomeMovieState {
  final List<Movie> movies;

  const HomeMovieNowPlayingHasData({required this.movies});

  @override
  List<Object> get props => [movies];
}
