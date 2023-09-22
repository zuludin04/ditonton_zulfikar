part of 'tv_series_recommendations_cubit.dart';

enum TvSeriesRecommendationsStatus { loading, error, empty, hasData }

final class TvSeriesRecommendationsState extends Equatable {
  final List<TvSeries> tvSeries;
  final String message;
  final TvSeriesRecommendationsStatus status;

  const TvSeriesRecommendationsState._({
    this.tvSeries = const <TvSeries>[],
    this.message = "",
    this.status = TvSeriesRecommendationsStatus.loading,
  });

  const TvSeriesRecommendationsState.loading() : this._();

  const TvSeriesRecommendationsState.empty()
      : this._(status: TvSeriesRecommendationsStatus.empty);

  const TvSeriesRecommendationsState.error(String message)
      : this._(message: message, status: TvSeriesRecommendationsStatus.error);

  const TvSeriesRecommendationsState.hasData(List<TvSeries> tvSeries)
      : this._(
            tvSeries: tvSeries, status: TvSeriesRecommendationsStatus.hasData);

  @override
  List<Object> get props => [tvSeries, message, status];
}
