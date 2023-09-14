part of 'movie_tvseries_search_cubit.dart';

abstract class MovieTvSeriesSearchState extends Equatable {
  const MovieTvSeriesSearchState();

  @override
  List<Object> get props => [];
}

class MovieTvSeriesSearchInitial extends MovieTvSeriesSearchState {}

class SearchEmpty extends MovieTvSeriesSearchState {}

class SearchLoading extends MovieTvSeriesSearchState {}

class SearchError extends MovieTvSeriesSearchState {
  final String message;

  const SearchError({required this.message});

  @override
  List<Object> get props => [message];
}

class SearchHasData extends MovieTvSeriesSearchState {
  final List<SearchResult> result;

  const SearchHasData({required this.result});

  @override
  List<Object> get props => [result];
}
