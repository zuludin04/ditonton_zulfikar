import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/search_result.dart';
import 'package:ditonton/domain/usecases/search_movies_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchMoviesTvSeries usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SearchMoviesTvSeries(mockMovieRepository, mockTvSeriesRepository);
  });

  final tResult = <SearchResult>[];
  const tQuery = 'Spiderman';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.searchMovies(tQuery))
        .thenAnswer((_) async => Right(tResult));
    // act
    final result = await usecase.execute(true, tQuery);
    // assert
    expect(result, equals(Right<Failure, List<SearchResult>>(tResult)));
  });

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.searchTvSeries(tQuery))
        .thenAnswer((_) async => Right(tResult));
    // act
    final result = await usecase.execute(false, tQuery);
    // assert
    expect(result, equals(Right<Failure, List<SearchResult>>(tResult)));
  });
}
