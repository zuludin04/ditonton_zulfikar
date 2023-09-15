import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies_status.dart';
import 'package:ditonton/domain/usecases/remove_movies_watchlist.dart';
import 'package:ditonton/domain/usecases/save_movies_watchlist.dart';
import 'package:ditonton/presentation/bloc/movies/detail/movie_detail_watchlist_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_watchlist_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchListMoviesStatus,
  SaveMoviesWatchlist,
  RemoveMoviesWatchlist,
])
void main() {
  late MovieDetailWatchlistCubit movieCubit;
  late MockGetWatchListMoviesStatus mockGetWatchlistStatus;
  late MockSaveMoviesWatchlist mockSaveWatchlist;
  late MockRemoveMoviesWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistStatus = MockGetWatchListMoviesStatus();
    mockSaveWatchlist = MockSaveMoviesWatchlist();
    mockRemoveWatchlist = MockRemoveMoviesWatchlist();
    movieCubit = MovieDetailWatchlistCubit(
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  group('Watchlist', () {
    blocTest<MovieDetailWatchlistCubit, MovieDetailWatchlistState>(
      'should get the watchlist status',
      build: () {
        when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
        return movieCubit;
      },
      act: (bloc) {
        bloc.loadWatchlistStatus(1);
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <MovieDetailWatchlistState>[
        const MovieDetailWatchlistStatus(isWatchlist: true),
      ],
    );

    blocTest<MovieDetailWatchlistCubit, MovieDetailWatchlistState>(
      'should execute save watchlist when function called',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieCubit;
      },
      act: (bloc) {
        bloc.addWatchlist(testMovieDetail);
      },
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieDetailWatchlistCubit, MovieDetailWatchlistState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieCubit;
      },
      act: (bloc) {
        bloc.removeFromWatchlist(testMovieDetail);
      },
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieDetailWatchlistCubit, MovieDetailWatchlistState>(
      'should update watchlist status when add watchlist success',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added To Watchlist'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieCubit;
      },
      act: (bloc) {
        bloc.addWatchlist(testMovieDetail);
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <MovieDetailWatchlistState>[
        const MovieDetailWatchlistChangeStatus(message: 'Added To Watchlist'),
        const MovieDetailWatchlistStatus(isWatchlist: true),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
      },
    );

    blocTest<MovieDetailWatchlistCubit, MovieDetailWatchlistState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieCubit;
      },
      act: (bloc) {
        bloc.addWatchlist(testMovieDetail);
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <MovieDetailWatchlistState>[
        const MovieDetailWatchlistChangeStatus(message: 'Failed'),
        const MovieDetailWatchlistStatus(isWatchlist: false),
      ],
    );
  });
}
