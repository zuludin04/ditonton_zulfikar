import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_recommendations_state.dart';

class TvSeriesRecommendationsCubit extends Cubit<TvSeriesRecommendationsState> {
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TvSeriesRecommendationsCubit({required this.getTvSeriesRecommendations})
      : super(const TvSeriesRecommendationsState.loading());

  Future<void> fetchTvSeriesRecommendations(int id) async {
    var recommendationResult = await getTvSeriesRecommendations.execute(id);
    recommendationResult.fold(
      (failure) {
        emit(TvSeriesRecommendationsState.error(failure.message));
      },
      (series) {
        emit(TvSeriesRecommendationsState.hasData(series));
      },
    );
  }
}
