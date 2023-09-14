import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/search_result.dart';
import 'package:ditonton/domain/usecases/search_movies_tvseries.dart';
import 'package:ditonton/presentation/bloc/movie_tvseries_search_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_tvseries_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMoviesTvSeries])
void main() {
  late MovieTvSeriesSearchCubit searchBloc;
  late MockSearchMoviesTvSeries mockSearchMoviesTvSeries;

  setUp(() {
    mockSearchMoviesTvSeries = MockSearchMoviesTvSeries();
    searchBloc =
        MovieTvSeriesSearchCubit(searchMovies: mockSearchMoviesTvSeries);
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

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
  });

  blocTest<MovieTvSeriesSearchCubit, MovieTvSeriesSearchState>(
    'Should emit [Loading, HasData] when movie data is gotten successfully',
    build: () {
      when(mockSearchMoviesTvSeries.execute(true, 'spiderman'))
          .thenAnswer((realInvocation) async => Right(tMovieList));
      return searchBloc;
    },
    act: (bloc) {
      bloc.onQueryChanged(true, 'spiderman');
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <MovieTvSeriesSearchState>[
      SearchLoading(),
      SearchHasData(result: tMovieList)
    ],
    verify: (bloc) {
      verify(mockSearchMoviesTvSeries.execute(true, 'spiderman'));
    },
  );

  blocTest<MovieTvSeriesSearchCubit, MovieTvSeriesSearchState>(
    'Should emit [Loading, Error] when movie get search is unsuccessfully',
    build: () {
      when(mockSearchMoviesTvSeries.execute(true, 'spiderman')).thenAnswer(
          (realInvocation) async =>
              const Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) {
      bloc.onQueryChanged(true, 'spiderman');
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <MovieTvSeriesSearchState>[
      SearchLoading(),
      const SearchError(message: 'Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMoviesTvSeries.execute(true, 'spiderman'));
    },
  );

  blocTest<MovieTvSeriesSearchCubit, MovieTvSeriesSearchState>(
    'Should emit [Loading, HasData] when tv series data is gotten successfully',
    build: () {
      when(mockSearchMoviesTvSeries.execute(false, 'Good Mythical Morning'))
          .thenAnswer((realInvocation) async => Right(tTvSeriesList));
      return searchBloc;
    },
    act: (bloc) {
      bloc.onQueryChanged(false, 'Good Mythical Morning');
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <MovieTvSeriesSearchState>[
      SearchLoading(),
      SearchHasData(result: tTvSeriesList)
    ],
    verify: (bloc) {
      verify(mockSearchMoviesTvSeries.execute(false, 'Good Mythical Morning'));
    },
  );

  blocTest<MovieTvSeriesSearchCubit, MovieTvSeriesSearchState>(
    'Should emit [Loading, Error] when tv series get search is unsuccessfully',
    build: () {
      when(mockSearchMoviesTvSeries.execute(false, 'Good Mythical Morning'))
          .thenAnswer((realInvocation) async =>
              const Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) {
      bloc.onQueryChanged(false, 'Good Mythical Morning');
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <MovieTvSeriesSearchState>[
      SearchLoading(),
      const SearchError(message: 'Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMoviesTvSeries.execute(false, 'Good Mythical Morning'));
    },
  );
}
