import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/tvseries/detail/tv_series_detail_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_cubit_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late TvSeriesDetailCubit tvSeriesCubit;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    tvSeriesCubit =
        TvSeriesDetailCubit(getTvSeriesDetail: mockGetTvSeriesDetail);
  });

  const tId = 1;

  void arrangeUsecase() {
    when(mockGetTvSeriesDetail.execute(tId))
        .thenAnswer((_) async => const Right(testTvSeriesDetail));
  }

  test('initial state is TvSeriesDetailState.loading', () {
    expect(
      tvSeriesCubit.state,
      const TvSeriesDetailState.loading(),
    );
  });

  group('Get TvSeries Detail', () {
    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should get data from usecase',
      build: () {
        arrangeUsecase();
        return tvSeriesCubit;
      },
      act: (bloc) {
        bloc.fetchTvSeriesDetail(tId);
      },
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(tId));
      },
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should change TvSeries detail when data is gotten successfully',
      build: () {
        arrangeUsecase();
        return tvSeriesCubit;
      },
      act: (bloc) {
        bloc.fetchTvSeriesDetail(tId);
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <TvSeriesDetailState>[
        const TvSeriesDetailState.hasData(testTvSeriesDetail),
      ],
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should return error when get TvSeries detail is unsuccessfully',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSeriesCubit;
      },
      act: (bloc) {
        bloc.fetchTvSeriesDetail(tId);
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <TvSeriesDetailState>[
        const TvSeriesDetailState.error('Server Failure'),
      ],
    );
  });
}
