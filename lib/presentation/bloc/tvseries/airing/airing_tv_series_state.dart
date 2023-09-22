part of 'airing_tv_series_cubit.dart';

enum AiringTvSeriesStatus { loading, error, hasData }

final class AiringTvSeriesState extends Equatable {
  final List<TvSeries> tvSeries;
  final String message;
  final AiringTvSeriesStatus status;

  const AiringTvSeriesState._({
    this.tvSeries = const <TvSeries>[],
    this.message = "",
    this.status = AiringTvSeriesStatus.loading,
  });

  const AiringTvSeriesState.loading() : this._();

  const AiringTvSeriesState.error(String message)
      : this._(message: message, status: AiringTvSeriesStatus.error);

  const AiringTvSeriesState.hasData(List<TvSeries> tvSeries)
      : this._(tvSeries: tvSeries, status: AiringTvSeriesStatus.hasData);

  @override
  List<Object> get props => [tvSeries, message, status];
}
