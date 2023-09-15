import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/presentation/bloc/tvseries/detail/tv_series_recommendations_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_recommendations_cubit_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late TvSeriesRecommendationsCubit tvSeriesCubit;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    tvSeriesCubit = TvSeriesRecommendationsCubit(
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
    );
  });

  const tId = 1;

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

  void arrangeUsecase() {
    when(mockGetTvSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvSeriesList));
  }

  group('Get TvSeries Recommendations', () {
    blocTest<TvSeriesRecommendationsCubit, TvSeriesRecommendationsState>(
      'should get data from usecase',
      build: () {
        arrangeUsecase();
        return tvSeriesCubit;
      },
      act: (bloc) {
        bloc.fetchTvSeriesRecommendations(tId);
      },
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );

    blocTest<TvSeriesRecommendationsCubit, TvSeriesRecommendationsState>(
      'should change TvSeries recommendations when data is gotten successfully',
      build: () {
        arrangeUsecase();
        return tvSeriesCubit;
      },
      act: (bloc) {
        bloc.fetchTvSeriesRecommendations(tId);
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <TvSeriesRecommendationsState>[
        TvSeriesRecommendationsLoading(),
        TvSeriesRecommendationsHasData(tvSeries: tTvSeriesList),
      ],
    );

    blocTest<TvSeriesRecommendationsCubit, TvSeriesRecommendationsState>(
      'should change status when get TvSeries detail is successfully but return error when data recommendations is unsuccessfully',
      build: () {
        when(mockGetTvSeriesRecommendations.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSeriesCubit;
      },
      act: (bloc) {
        bloc.fetchTvSeriesRecommendations(tId);
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <TvSeriesRecommendationsState>[
        TvSeriesRecommendationsLoading(),
        const TvSeriesRecommendationsError(message: 'Server Failure'),
      ],
    );
  });
}
