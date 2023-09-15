part of 'tv_series_recommendations_cubit.dart';

abstract class TvSeriesRecommendationsState extends Equatable {
  const TvSeriesRecommendationsState();

  @override
  List<Object> get props => [];
}

class TvSeriesRecommendationsInitial extends TvSeriesRecommendationsState {}

class TvSeriesRecommendationsLoading extends TvSeriesRecommendationsState {}

class TvSeriesRecommendationsEmpty extends TvSeriesRecommendationsState {}

class TvSeriesRecommendationsError extends TvSeriesRecommendationsState {
  final String message;

  const TvSeriesRecommendationsError({required this.message});

  @override
  List<Object> get props => [message];
}

class TvSeriesRecommendationsHasData extends TvSeriesRecommendationsState {
  final List<TvSeries> tvSeries;

  const TvSeriesRecommendationsHasData({required this.tvSeries});

  @override
  List<Object> get props => [tvSeries];
}
