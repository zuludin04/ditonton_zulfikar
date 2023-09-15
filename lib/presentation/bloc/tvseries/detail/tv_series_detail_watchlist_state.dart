part of 'tv_series_detail_watchlist_cubit.dart';

abstract class TvSeriesDetailWatchlistState extends Equatable {
  const TvSeriesDetailWatchlistState();

  @override
  List<Object> get props => [];
}

class TvSeriesDetailWatchlistInitial extends TvSeriesDetailWatchlistState {}

class TvSeriesDetailWatchlistStatus extends TvSeriesDetailWatchlistState {
  final bool isWatchlist;

  const TvSeriesDetailWatchlistStatus({required this.isWatchlist});

  @override
  List<Object> get props => [isWatchlist];
}

class TvSeriesDetailWatchlistChangeStatus extends TvSeriesDetailWatchlistState {
  final String message;

  const TvSeriesDetailWatchlistChangeStatus({required this.message});

  @override
  List<Object> get props => [message];
}
