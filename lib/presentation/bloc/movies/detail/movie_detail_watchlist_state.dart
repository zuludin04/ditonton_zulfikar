part of 'movie_detail_watchlist_cubit.dart';

enum MovieDetailWatchlistStatus {
  initial,
  isWatchlistStatus,
  changeWatchlistStatus
}

final class MovieDetailWatchlistState extends Equatable {
  final bool isWatchlist;
  final String message;
  final MovieDetailWatchlistStatus status;

  const MovieDetailWatchlistState._({
    this.isWatchlist = false,
    this.message = "",
    this.status = MovieDetailWatchlistStatus.initial,
  });

  const MovieDetailWatchlistState.initial() : this._();

  const MovieDetailWatchlistState.watchlistStatus(bool isWatchlist)
      : this._(
            isWatchlist: isWatchlist,
            status: MovieDetailWatchlistStatus.isWatchlistStatus);

  const MovieDetailWatchlistState.changeStatus(String message)
      : this._(
            message: message,
            status: MovieDetailWatchlistStatus.changeWatchlistStatus);

  @override
  List<Object> get props => [isWatchlist, message, status];
}
