part of 'home_tv_series_cubit.dart';

abstract class HomeTvSeriesState extends Equatable {
  const HomeTvSeriesState();

  @override
  List<Object> get props => [];
}

class HomeTvSeriesInitial extends HomeTvSeriesState {}

class HomeTvSeriesPopularLoading extends HomeTvSeriesState {}

class HomeTvSeriesPopularError extends HomeTvSeriesState {
  final String message;

  const HomeTvSeriesPopularError({required this.message});

  @override
  List<Object> get props => [message];
}

class HomeTvSeriesPopularHasData extends HomeTvSeriesState {
  final List<TvSeries> tvSeries;

  const HomeTvSeriesPopularHasData({required this.tvSeries});

  @override
  List<Object> get props => [tvSeries];
}

class HomeTvSeriesTopRatedLoading extends HomeTvSeriesState {}

class HomeTvSeriesTopRatedError extends HomeTvSeriesState {
  final String message;

  const HomeTvSeriesTopRatedError({required this.message});

  @override
  List<Object> get props => [message];
}

class HomeTvSeriesTopRatedHasData extends HomeTvSeriesState {
  final List<TvSeries> tvSeries;

  const HomeTvSeriesTopRatedHasData({required this.tvSeries});

  @override
  List<Object> get props => [tvSeries];
}

class HomeTvSeriesAiringLoading extends HomeTvSeriesState {}

class HomeTvSeriesAiringError extends HomeTvSeriesState {
  final String message;

  const HomeTvSeriesAiringError({required this.message});

  @override
  List<Object> get props => [message];
}

class HomeTvSeriesAiringHasData extends HomeTvSeriesState {
  final List<TvSeries> tvSeries;

  const HomeTvSeriesAiringHasData({required this.tvSeries});

  @override
  List<Object> get props => [tvSeries];
}
