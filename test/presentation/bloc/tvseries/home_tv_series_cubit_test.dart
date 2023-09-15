import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_airing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/tvseries/home/home_tv_series_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_tv_series_cubit_test.mocks.dart';

@GenerateMocks([GetAiringTvSeries, GetPopularTvSeries, GetTopRatedTvSeries])
void main() {
  late HomeTvSeriesCubit tvSeriesCubit;
  late MockGetAiringTvSeries mockGetAiringTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetAiringTvSeries = MockGetAiringTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    tvSeriesCubit = HomeTvSeriesCubit(
      getAiringTvSeries: mockGetAiringTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    );
  });

  final tTvSeries = TvSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: const [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: const ['id'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvSeriesList = [tTvSeries];

  group('airing tv series', () {
    blocTest<HomeTvSeriesCubit, HomeTvSeriesState>(
      'should change state to loading when usecase is called',
      build: () {
        when(mockGetAiringTvSeries.execute())
            .thenAnswer((realInvocation) async => Right(tTvSeriesList));
        return tvSeriesCubit;
      },
      act: (bloc) {
        bloc.fetchAiringTvSeries();
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <HomeTvSeriesState>[
        HomeTvSeriesAiringLoading(),
        HomeTvSeriesAiringHasData(tvSeries: tTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetAiringTvSeries.execute());
      },
    );

    blocTest<HomeTvSeriesCubit, HomeTvSeriesState>(
      'should return error when data is unsuccessful',
      build: () {
        when(mockGetAiringTvSeries.execute()).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return tvSeriesCubit;
      },
      act: (bloc) {
        bloc.fetchAiringTvSeries();
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <HomeTvSeriesState>[
        HomeTvSeriesAiringLoading(),
        const HomeTvSeriesAiringError(message: 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetAiringTvSeries.execute());
      },
    );
  });

  group('top rated tv series', () {
    blocTest<HomeTvSeriesCubit, HomeTvSeriesState>(
      'should change state to loading when usecase is called',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((realInvocation) async => Right(tTvSeriesList));
        return tvSeriesCubit;
      },
      act: (bloc) {
        bloc.fetchTopRatedMovies();
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <HomeTvSeriesState>[
        HomeTvSeriesTopRatedLoading(),
        HomeTvSeriesTopRatedHasData(tvSeries: tTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );

    blocTest<HomeTvSeriesCubit, HomeTvSeriesState>(
      'should return error when data is unsuccessful',
      build: () {
        when(mockGetTopRatedTvSeries.execute()).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return tvSeriesCubit;
      },
      act: (bloc) {
        bloc.fetchTopRatedMovies();
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <HomeTvSeriesState>[
        HomeTvSeriesTopRatedLoading(),
        const HomeTvSeriesTopRatedError(message: 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );
  });

  group('popular movies', () {
    blocTest<HomeTvSeriesCubit, HomeTvSeriesState>(
      'should change state to loading when usecase is called',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((realInvocation) async => Right(tTvSeriesList));
        return tvSeriesCubit;
      },
      act: (bloc) {
        bloc.fetchPopularMovies();
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <HomeTvSeriesState>[
        HomeTvSeriesPopularLoading(),
        HomeTvSeriesPopularHasData(tvSeries: tTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      },
    );

    blocTest<HomeTvSeriesCubit, HomeTvSeriesState>(
      'should return error when data is unsuccessful',
      build: () {
        when(mockGetPopularTvSeries.execute()).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return tvSeriesCubit;
      },
      act: (bloc) {
        bloc.fetchPopularMovies();
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <HomeTvSeriesState>[
        HomeTvSeriesPopularLoading(),
        const HomeTvSeriesPopularError(message: 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      },
    );
  });
}
