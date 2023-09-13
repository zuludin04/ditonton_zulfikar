import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_airing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter/material.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  var _airingTvSeries = <TvSeries>[];
  List<TvSeries> get airingTvSeries => _airingTvSeries;

  RequestState _airingTvSeriesState = RequestState.empty;
  RequestState get airingTvSeriesState => _airingTvSeriesState;

  var _popularTvSeries = <TvSeries>[];
  List<TvSeries> get popularTvSeries => _popularTvSeries;

  RequestState _popularTvSeriesState = RequestState.empty;
  RequestState get popularTvSeriesState => _popularTvSeriesState;

  var _topRatedTvSeries = <TvSeries>[];
  List<TvSeries> get topRatedTvSeries => _topRatedTvSeries;

  RequestState _topRatedTvSeriesState = RequestState.empty;
  RequestState get topRatedTvSeriesState => _topRatedTvSeriesState;

  String _message = '';
  String get message => _message;

  TvSeriesListNotifier({
    required this.getAiringTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  });

  final GetAiringTvSeries getAiringTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  Future<void> fetchAiringTvSeries() async {
    _airingTvSeriesState = RequestState.loading;
    notifyListeners();

    final result = await getAiringTvSeries.execute();
    result.fold(
          (failure) {
        _airingTvSeriesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
          (tvSeriesData) {
        _airingTvSeriesState = RequestState.loaded;
        _airingTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvSeries() async {
    _popularTvSeriesState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();
    result.fold(
          (failure) {
        _popularTvSeriesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
          (tvSeriesData) {
        _popularTvSeriesState = RequestState.loaded;
        _popularTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedTvSeriesState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();
    result.fold(
          (failure) {
        _topRatedTvSeriesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
          (tvSeriesData) {
        _topRatedTvSeriesState = RequestState.loaded;
        _topRatedTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}