import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_recommendations_state.dart';

class TvSeriesRecommendationsCubit extends Cubit<TvSeriesRecommendationsState> {
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TvSeriesRecommendationsCubit({required this.getTvSeriesRecommendations})
      : super(TvSeriesRecommendationsInitial());

  Future<void> fetchTvSeriesRecommendations(int id) async {
    emit(TvSeriesRecommendationsLoading());

    var recommendationResult = await getTvSeriesRecommendations.execute(id);
    recommendationResult.fold(
      (failure) {
        emit(TvSeriesRecommendationsError(message: failure.message));
      },
      (series) {
        emit(TvSeriesRecommendationsHasData(tvSeries: series));
      },
    );
  }
}
