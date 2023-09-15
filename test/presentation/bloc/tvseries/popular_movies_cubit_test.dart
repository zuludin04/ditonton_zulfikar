import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/tvseries/popular/popular_tv_series_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_cubit_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late PopularTvSeriesCubit tvSeriesCubit;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    tvSeriesCubit =
        PopularTvSeriesCubit(getPopularTvSeries: mockGetPopularTvSeries);
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

  blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
    'should change state to loading when usecase is called',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((realInvocation) async => Right(tTvSeriesList));
      return tvSeriesCubit;
    },
    act: (bloc) {
      bloc.fetchPopularTvSeries();
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <PopularTvSeriesState>[
      PopularTvSeriesLoading(),
      PopularTvSeriesHasData(tvSeries: tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );

  blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockGetPopularTvSeries.execute()).thenAnswer(
          (realInvocation) async =>
              const Left(ServerFailure('Server Failure')));
      return tvSeriesCubit;
    },
    act: (bloc) {
      bloc.fetchPopularTvSeries();
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <PopularTvSeriesState>[
      PopularTvSeriesLoading(),
      const PopularTvSeriesError(message: 'Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );
}
