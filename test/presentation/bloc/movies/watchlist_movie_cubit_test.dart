import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/movies/watchlist/watchlist_movie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movie_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late WatchlistMovieCubit moviesCubit;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    moviesCubit =
        WatchlistMovieCubit(getWatchlistMovies: mockGetWatchlistMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  blocTest<WatchlistMovieCubit, WatchlistMovieState>(
    'should change state to loading when usecase is called',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((realInvocation) async => Right(tMovieList));
      return moviesCubit;
    },
    act: (bloc) {
      bloc.fetchWatchlistMovies();
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <WatchlistMovieState>[
      WatchlistMovieLoading(),
      WatchlistMovieHasData(movies: tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMovieCubit, WatchlistMovieState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
          (realInvocation) async =>
              const Left(DatabaseFailure('Database Failure')));
      return moviesCubit;
    },
    act: (bloc) {
      bloc.fetchWatchlistMovies();
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <WatchlistMovieState>[
      WatchlistMovieLoading(),
      const WatchlistMovieError(message: 'Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
