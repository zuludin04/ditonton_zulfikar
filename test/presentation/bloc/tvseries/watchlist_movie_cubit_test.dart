import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/tvseries/watchlist/watchlist_tv_series_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movie_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late WatchlistTvSeriesCubit tvSeriesCubit;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    tvSeriesCubit =
        WatchlistTvSeriesCubit(getWatchlistTvSeries: mockGetWatchlistTvSeries);
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

  blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
    'should change state to loading when usecase is called',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((realInvocation) async => Right(tTvSeriesList));
      return tvSeriesCubit;
    },
    act: (bloc) {
      bloc.fetchWatchlistTvSeries();
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <WatchlistTvSeriesState>[
      WatchlistTvSeriesLoading(),
      WatchlistTvSeriesHasData(tvSeries: tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockGetWatchlistTvSeries.execute()).thenAnswer(
          (realInvocation) async =>
              const Left(DatabaseFailure('Database Failure')));
      return tvSeriesCubit;
    },
    act: (bloc) {
      bloc.fetchWatchlistTvSeries();
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <WatchlistTvSeriesState>[
      WatchlistTvSeriesLoading(),
      const WatchlistTvSeriesError(message: 'Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );
}
