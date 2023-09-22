part of 'tv_series_detail_cubit.dart';

enum TvSeriesDetailStatus { loading, error, hasData }

final class TvSeriesDetailState extends Equatable {
  final TvSeriesDetail? detail;
  final String message;
  final TvSeriesDetailStatus status;

  const TvSeriesDetailState._({
    this.detail,
    this.message = "",
    this.status = TvSeriesDetailStatus.loading,
  });

  const TvSeriesDetailState.loading() : this._();

  const TvSeriesDetailState.hasData(TvSeriesDetail detail)
      : this._(status: TvSeriesDetailStatus.hasData, detail: detail);

  const TvSeriesDetailState.error(String message)
      : this._(status: TvSeriesDetailStatus.error, message: message);

  @override
  List<Object> get props => [message, status];
}
