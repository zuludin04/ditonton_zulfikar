import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/search_result.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class SearchMoviesTvSeries {
  final MovieRepository movieRepository;
  final TvSeriesRepository tvSeriesRepository;

  SearchMoviesTvSeries(this.movieRepository, this.tvSeriesRepository);

  Future<Either<Failure, List<SearchResult>>> execute(
      bool searchMovie, String query) async {
    if (searchMovie) {
      return movieRepository.searchMovies(query);
    } else {
      return tvSeriesRepository.searchTvSeries(query);
    }
  }
}
