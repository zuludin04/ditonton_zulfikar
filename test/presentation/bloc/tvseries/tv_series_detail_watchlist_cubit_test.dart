import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:ditonton/presentation/bloc/tvseries/detail/tv_series_detail_watchlist_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_watchlist_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchListTvSeriesStatus,
  SaveTvSeriesWatchlist,
  RemoveTvSeriesWatchlist,
])
void main() {
  late TvSeriesDetailWatchlistCubit tvSeriesCubit;
  late MockGetWatchListTvSeriesStatus mockGetWatchlistStatus;
  late MockSaveTvSeriesWatchlist mockSaveWatchlist;
  late MockRemoveTvSeriesWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistStatus = MockGetWatchListTvSeriesStatus();
    mockSaveWatchlist = MockSaveTvSeriesWatchlist();
    mockRemoveWatchlist = MockRemoveTvSeriesWatchlist();
    tvSeriesCubit = TvSeriesDetailWatchlistCubit(
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  group('Watchlist', () {
    blocTest<TvSeriesDetailWatchlistCubit, TvSeriesDetailWatchlistState>(
      'should get the watchlist status',
      build: () {
        when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
        return tvSeriesCubit;
      },
      act: (bloc) {
        bloc.loadWatchlistStatus(1);
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <TvSeriesDetailWatchlistState>[
        const TvSeriesDetailWatchlistStatus(isWatchlist: true),
      ],
    );

    blocTest<TvSeriesDetailWatchlistCubit, TvSeriesDetailWatchlistState>(
      'should execute save watchlist when function called',
      build: () {
        when(mockSaveWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return tvSeriesCubit;
      },
      act: (bloc) {
        bloc.addWatchlist(testTvSeriesDetail);
      },
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testTvSeriesDetail));
      },
    );

    blocTest<TvSeriesDetailWatchlistCubit, TvSeriesDetailWatchlistState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockRemoveWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return tvSeriesCubit;
      },
      act: (bloc) {
        bloc.removeFromWatchlist(testTvSeriesDetail);
      },
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testTvSeriesDetail));
      },
    );

    blocTest<TvSeriesDetailWatchlistCubit, TvSeriesDetailWatchlistState>(
      'should update watchlist status when add watchlist success',
      build: () {
        when(mockSaveWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Added To Watchlist'));
        when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return tvSeriesCubit;
      },
      act: (bloc) {
        bloc.addWatchlist(testTvSeriesDetail);
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <TvSeriesDetailWatchlistState>[
        const TvSeriesDetailWatchlistChangeStatus(
            message: 'Added To Watchlist'),
        const TvSeriesDetailWatchlistStatus(isWatchlist: true),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistStatus.execute(testTvSeriesDetail.id));
      },
    );

    blocTest<TvSeriesDetailWatchlistCubit, TvSeriesDetailWatchlistState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockSaveWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return tvSeriesCubit;
      },
      act: (bloc) {
        bloc.addWatchlist(testTvSeriesDetail);
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <TvSeriesDetailWatchlistState>[
        const TvSeriesDetailWatchlistChangeStatus(message: 'Failed'),
        const TvSeriesDetailWatchlistStatus(isWatchlist: false),
      ],
    );
  });
}
