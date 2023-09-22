import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_watchlist_state.dart';

class TvSeriesDetailWatchlistCubit extends Cubit<TvSeriesDetailWatchlistState> {
  final GetWatchListTvSeriesStatus getWatchListStatus;
  final SaveTvSeriesWatchlist saveWatchlist;
  final RemoveTvSeriesWatchlist removeWatchlist;

  TvSeriesDetailWatchlistCubit({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(const TvSeriesDetailWatchlistState.initial());

  Future<void> addWatchlist(TvSeriesDetail tvSeries) async {
    final result = await saveWatchlist.execute(tvSeries);

    await result.fold(
      (failure) async {
        emit(TvSeriesDetailWatchlistState.changeStatus(failure.message));
      },
      (successMessage) async {
        emit(TvSeriesDetailWatchlistState.changeStatus(successMessage));
      },
    );

    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail tvSeries) async {
    final result = await removeWatchlist.execute(tvSeries);

    await result.fold(
      (failure) async {
        emit(TvSeriesDetailWatchlistState.changeStatus(failure.message));
      },
      (successMessage) async {
        emit(TvSeriesDetailWatchlistState.changeStatus(successMessage));
      },
    );

    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(TvSeriesDetailWatchlistState.watchlistStatus(result));
  }
}
