import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesCubit extends Cubit<TopRatedTvSeriesState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesCubit({required this.getTopRatedTvSeries})
      : super(const TopRatedTvSeriesState.loading());

  Future<void> fetchTopRatedTvSeries() async {
    final result = await getTopRatedTvSeries.execute();

    result.fold(
      (failure) {
        emit(TopRatedTvSeriesState.error(failure.message));
      },
      (seriesData) {
        emit(TopRatedTvSeriesState.hasData(seriesData));
      },
    );
  }
}
