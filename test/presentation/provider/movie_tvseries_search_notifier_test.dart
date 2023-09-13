import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/search_result.dart';
import 'package:ditonton/domain/usecases/search_movies_tvseries.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_tvseries_search_notifier_test.mocks.dart';

@GenerateMocks([SearchMoviesTvSeries])
void main() {
  late MovieSearchNotifier provider;
  late MockSearchMoviesTvSeries mockSearchMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchMovies = MockSearchMoviesTvSeries();
    provider = MovieSearchNotifier(searchMovies: mockSearchMovies)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tSearchMovieModel = SearchResult(
    id: 557,
    title: 'Spider-Man',
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    description:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    type: 'movie',
  );

  const tSearchTvSeriesModel = SearchResult(
    id: 65701,
    title: 'Good Mythical Morning',
    posterPath: '/hH4YaZuH89Hlyz0DEkf362Mj8gU.jpg',
    description:
        "Two Internetainers (Rhett & Link) go far out and do the weirdest  things",
    type: 'tv_series',
  );

  final tMovieList = <SearchResult>[tSearchMovieModel];
  final tTvSeriesList = <SearchResult>[tSearchTvSeriesModel];

  group('search movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchMovies.execute(true, 'spiderman'))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchMovieSearch(true, 'spiderman');
      // assert
      expect(provider.searchState, RequestState.loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchMovies.execute(true, 'spiderman'))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchMovieSearch(true, 'spiderman');
      // assert
      expect(provider.searchState, RequestState.loaded);
      expect(provider.searchResult, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchMovies.execute(true, 'spiderman'))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchMovieSearch(true, 'spiderman');
      // assert
      expect(provider.searchState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('search tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchMovies.execute(false, 'Good Mythical Morning'))
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchMovieSearch(false, 'Good Mythical Morning');
      // assert
      expect(provider.searchState, RequestState.loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchMovies.execute(false, 'Good Mythical Morning'))
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchMovieSearch(false, 'Good Mythical Morning');
      // assert
      expect(provider.searchState, RequestState.loaded);
      expect(provider.searchResult, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchMovies.execute(true, 'Good Mythical Morning'))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchMovieSearch(true, 'Good Mythical Morning');
      // assert
      expect(provider.searchState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
