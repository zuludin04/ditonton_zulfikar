part of 'tv_series_detail_cubit.dart';

abstract class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();

  @override
  List<Object> get props => [];
}

class TvSeriesDetailInitial extends TvSeriesDetailState {}

class TvSeriesDetailLoading extends TvSeriesDetailState {}

class TvSeriesDetailError extends TvSeriesDetailState {
  final String message;

  const TvSeriesDetailError({required this.message});

  @override
  List<Object> get props => [message];
}

class TvSeriesDetailHasData extends TvSeriesDetailState {
  final TvSeriesDetail detail;

  const TvSeriesDetailHasData({required this.detail});

  @override
  List<Object> get props => [detail];
}
