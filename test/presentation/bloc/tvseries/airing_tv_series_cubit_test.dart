import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_airing_tv_series.dart';
import 'package:ditonton/presentation/bloc/tvseries/airing/airing_tv_series_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'airing_tv_series_cubit_test.mocks.dart';

@GenerateMocks([GetAiringTvSeries])
void main() {
  late MockGetAiringTvSeries mockGetAiringTvSeries;
  late AiringTvSeriesCubit tvSeriesCubit;

  setUp(() {
    mockGetAiringTvSeries = MockGetAiringTvSeries();
    tvSeriesCubit =
        AiringTvSeriesCubit(getAiringTvSeries: mockGetAiringTvSeries);
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

  blocTest<AiringTvSeriesCubit, AiringTvSeriesState>(
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
    expect: () => <AiringTvSeriesState>[
      AiringTvSeriesLoading(),
      AiringTvSeriesHasData(tvSeries: tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetAiringTvSeries.execute());
    },
  );

  blocTest<AiringTvSeriesCubit, AiringTvSeriesState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockGetAiringTvSeries.execute()).thenAnswer((realInvocation) async =>
          const Left(DatabaseFailure('Database Failure')));
      return tvSeriesCubit;
    },
    act: (bloc) {
      bloc.fetchAiringTvSeries();
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <AiringTvSeriesState>[
      AiringTvSeriesLoading(),
      const AiringTvSeriesError(message: 'Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetAiringTvSeries.execute());
    },
  );
}
