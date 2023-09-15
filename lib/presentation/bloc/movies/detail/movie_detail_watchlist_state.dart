part of 'movie_detail_watchlist_cubit.dart';

abstract class MovieDetailWatchlistState extends Equatable {
  const MovieDetailWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieDetailWatchlistInitial extends MovieDetailWatchlistState {}

class MovieDetailWatchlistStatus extends MovieDetailWatchlistState {
  final bool isWatchlist;

  const MovieDetailWatchlistStatus({required this.isWatchlist});

  @override
  List<Object> get props => [isWatchlist];
}

class MovieDetailWatchlistChangeStatus extends MovieDetailWatchlistState {
  final String message;

  const MovieDetailWatchlistChangeStatus({required this.message});

  @override
  List<Object> get props => [message];
}
