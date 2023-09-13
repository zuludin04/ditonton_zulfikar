import 'package:ditonton/data/models/movies/movie_model.dart';
import 'package:ditonton/data/models/tvseries/tv_series_model.dart';
import 'package:equatable/equatable.dart';

class SearchResult extends Equatable {
  final int id;
  final String title;
  final String? posterPath;
  final String description;
  final String type;

  const SearchResult({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.description,
    required this.type,
  });

  factory SearchResult.fromMovies(MovieModel movie) {
    return SearchResult(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      description: movie.overview,
      type: 'movie',
    );
  }

  factory SearchResult.fromTvSeries(TvSeriesModel tvSeries) {
    return SearchResult(
      id: tvSeries.id,
      title: tvSeries.originalName,
      posterPath: tvSeries.posterPath,
      description: tvSeries.overview,
      type: 'tv_series',
    );
  }

  @override
  List<Object?> get props => [id, title, posterPath, description, type];
}
