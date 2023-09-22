part of 'tv_series_detail_watchlist_cubit.dart';

enum TvSeriesDetailWatchlistStatus {
  initial,
  isWatchlistStatus,
  changeWatchlistStatus
}

final class TvSeriesDetailWatchlistState extends Equatable {
  final bool isWatchlist;
  final String message;
  final TvSeriesDetailWatchlistStatus status;

  const TvSeriesDetailWatchlistState._({
    this.isWatchlist = false,
    this.message = "",
    this.status = TvSeriesDetailWatchlistStatus.initial,
  });

  const TvSeriesDetailWatchlistState.initial() : this._();

  const TvSeriesDetailWatchlistState.watchlistStatus(bool isWatchlist)
      : this._(
      isWatchlist: isWatchlist,
      status: TvSeriesDetailWatchlistStatus.isWatchlistStatus);

  const TvSeriesDetailWatchlistState.changeStatus(String message)
      : this._(
      message: message,
      status: TvSeriesDetailWatchlistStatus.changeWatchlistStatus);

  @override
  List<Object> get props => [isWatchlist, message, status];
}
