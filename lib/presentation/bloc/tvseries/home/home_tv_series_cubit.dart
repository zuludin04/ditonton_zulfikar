import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_airing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'home_tv_series_state.dart';

class HomeTvSeriesCubit extends Cubit<HomeTvSeriesState> {
  final GetAiringTvSeries getAiringTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  HomeTvSeriesCubit({
    required this.getAiringTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  }) : super(HomeTvSeriesInitial());

  Future<void> fetchAiringTvSeries() async {
    emit(HomeTvSeriesAiringLoading());

    final result = await getAiringTvSeries.execute();
    result.fold(
      (failure) {
        emit(HomeTvSeriesAiringError(message: failure.message));
      },
      (seriesData) {
        emit(HomeTvSeriesAiringHasData(tvSeries: seriesData));
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    emit(HomeTvSeriesPopularLoading());

    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) {
        emit(HomeTvSeriesPopularError(message: failure.message));
      },
      (seriesData) {
        emit(HomeTvSeriesPopularHasData(tvSeries: seriesData));
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    emit(HomeTvSeriesTopRatedLoading());

    final result = await getTopRatedTvSeries.execute();
    result.fold(
      (failure) {
        emit(HomeTvSeriesTopRatedError(message: failure.message));
      },
      (seriesData) {
        emit(HomeTvSeriesTopRatedHasData(tvSeries: seriesData));
      },
    );
  }
}
