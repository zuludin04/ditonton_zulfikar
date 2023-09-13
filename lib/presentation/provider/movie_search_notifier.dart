import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/search_result.dart';
import 'package:ditonton/domain/usecases/search_movies_tvseries.dart';
import 'package:flutter/foundation.dart';

class MovieSearchNotifier extends ChangeNotifier {
  final SearchMoviesTvSeries searchMovies;

  MovieSearchNotifier({required this.searchMovies});

  RequestState _searchState = RequestState.empty;
  RequestState get searchState => _searchState;

  List<SearchResult> _searchResult = [];
  List<SearchResult> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieSearch(bool searchMovie, String query) async {
    _searchState = RequestState.loading;
    notifyListeners();

    final result = await searchMovies.execute(searchMovie, query);
    result.fold(
      (failure) {
        _message = failure.message;
        _searchState = RequestState.error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _searchState = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
