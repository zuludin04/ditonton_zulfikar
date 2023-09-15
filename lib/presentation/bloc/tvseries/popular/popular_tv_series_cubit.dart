import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_series_state.dart';

class PopularTvSeriesCubit extends Cubit<PopularTvSeriesState> {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesCubit({required this.getPopularTvSeries})
      : super(PopularTvSeriesInitial());

  Future<void> fetchPopularTvSeries() async {
    emit(PopularTvSeriesLoading());

    final result = await getPopularTvSeries.execute();

    result.fold(
      (failure) {
        emit(PopularTvSeriesError(message: failure.message));
      },
      (seriesData) {
        emit(PopularTvSeriesHasData(tvSeries: seriesData));
      },
    );
  }
}
