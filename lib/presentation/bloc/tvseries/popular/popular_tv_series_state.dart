part of 'popular_tv_series_cubit.dart';

enum PopularTvSeriesStatus { loading, error, hasData }

final class PopularTvSeriesState extends Equatable {
  final List<TvSeries> tvSeries;
  final String message;
  final PopularTvSeriesStatus status;

  const PopularTvSeriesState._({
    this.tvSeries = const <TvSeries>[],
    this.message = "",
    this.status = PopularTvSeriesStatus.loading,
  });

  const PopularTvSeriesState.loading() : this._();

  const PopularTvSeriesState.error(String message)
      : this._(message: message, status: PopularTvSeriesStatus.error);

  const PopularTvSeriesState.hasData(List<TvSeries> tvSeries)
      : this._(tvSeries: tvSeries, status: PopularTvSeriesStatus.hasData);

  @override
  List<Object> get props => [tvSeries, message, status];
}
