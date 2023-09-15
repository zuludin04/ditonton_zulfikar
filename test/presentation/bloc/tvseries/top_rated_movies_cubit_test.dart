import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/tvseries/toprated/top_rated_tv_series_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TopRatedTvSeriesCubit tvSeriesCubit;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    tvSeriesCubit =
        TopRatedTvSeriesCubit(getTopRatedTvSeries: mockGetTopRatedTvSeries);
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

  blocTest<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
    'should change state to loading when usecase is called',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((realInvocation) async => Right(tTvSeriesList));
      return tvSeriesCubit;
    },
    act: (bloc) {
      bloc.fetchTopRatedTvSeries();
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <TopRatedTvSeriesState>[
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesHasData(tvSeries: tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );

  blocTest<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockGetTopRatedTvSeries.execute()).thenAnswer(
          (realInvocation) async =>
              const Left(ServerFailure('Server Failure')));
      return tvSeriesCubit;
    },
    act: (bloc) {
      bloc.fetchTopRatedTvSeries();
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <TopRatedTvSeriesState>[
      TopRatedTvSeriesLoading(),
      const TopRatedTvSeriesError(message: 'Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );
}
