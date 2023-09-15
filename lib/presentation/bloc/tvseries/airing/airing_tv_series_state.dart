part of 'airing_tv_series_cubit.dart';

abstract class AiringTvSeriesState extends Equatable {
  const AiringTvSeriesState();

  @override
  List<Object> get props => [];
}

class AiringTvSeriesInitial extends AiringTvSeriesState {}

class AiringTvSeriesLoading extends AiringTvSeriesState {}

class AiringTvSeriesError extends AiringTvSeriesState {
  final String message;

  const AiringTvSeriesError({required this.message});

  @override
  List<Object> get props => [message];
}

class AiringTvSeriesHasData extends AiringTvSeriesState {
  final List<TvSeries> tvSeries;

  const AiringTvSeriesHasData({required this.tvSeries});

  @override
  List<Object> get props => [tvSeries];
}
