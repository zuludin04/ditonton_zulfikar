part of 'top_rated_tv_series_cubit.dart';

enum TopRatedTvSeriesStatus { loading, error, hasData }

final class TopRatedTvSeriesState extends Equatable {
  final List<TvSeries> tvSeries;
  final String message;
  final TopRatedTvSeriesStatus status;

  const TopRatedTvSeriesState._({
    this.tvSeries = const <TvSeries>[],
    this.message = "",
    this.status = TopRatedTvSeriesStatus.loading,
  });

  const TopRatedTvSeriesState.loading() : this._();

  const TopRatedTvSeriesState.error(String message)
      : this._(message: message, status: TopRatedTvSeriesStatus.error);

  const TopRatedTvSeriesState.hasData(List<TvSeries> tvSeries)
      : this._(tvSeries: tvSeries, status: TopRatedTvSeriesStatus.hasData);

  @override
  List<Object> get props => [tvSeries, message, status];
}
