import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesCubit extends Cubit<WatchlistTvSeriesState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvSeriesCubit({required this.getWatchlistTvSeries})
      : super(WatchlistTvSeriesInitial());

  Future<void> fetchWatchlistTvSeries() async {
    emit(WatchlistTvSeriesLoading());

    final result = await getWatchlistTvSeries.execute();

    result.fold(
      (failure) {
        emit(WatchlistTvSeriesError(message: failure.message));
      },
      (seriesData) {
        emit(WatchlistTvSeriesHasData(tvSeries: seriesData));
      },
    );
  }
}
