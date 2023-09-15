import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movies/home/home_movie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_movie_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late HomeMovieCubit moviesCubit;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    moviesCubit = HomeMovieCubit(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
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

  group('now playing movies', () {
    blocTest<HomeMovieCubit, HomeMovieState>(
      'should change state to loading when usecase is called',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((realInvocation) async => Right(tMovieList));
        return moviesCubit;
      },
      act: (bloc) {
        bloc.fetchNowPlayingMovies();
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <HomeMovieState>[
        HomeMovieNowPlayingLoading(),
        HomeMovieNowPlayingHasData(movies: tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<HomeMovieCubit, HomeMovieState>(
      'should return error when data is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer((realInvocation) async =>
        const Left(ServerFailure('Server Failure')));
        return moviesCubit;
      },
      act: (bloc) {
        bloc.fetchNowPlayingMovies();
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <HomeMovieState>[
        HomeMovieNowPlayingLoading(),
        const HomeMovieNowPlayingError(message: 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

  group('top rated movies', () {
    blocTest<HomeMovieCubit, HomeMovieState>(
      'should change state to loading when usecase is called',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((realInvocation) async => Right(tMovieList));
        return moviesCubit;
      },
      act: (bloc) {
        bloc.fetchTopRatedMovies();
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <HomeMovieState>[
        HomeMovieTopRatedLoading(),
        HomeMovieTopRatedHasData(movies: tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<HomeMovieCubit, HomeMovieState>(
      'should return error when data is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer((realInvocation) async =>
        const Left(ServerFailure('Server Failure')));
        return moviesCubit;
      },
      act: (bloc) {
        bloc.fetchTopRatedMovies();
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <HomeMovieState>[
        HomeMovieTopRatedLoading(),
        const HomeMovieTopRatedError(message: 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });

  group('popular movies', () {
    blocTest<HomeMovieCubit, HomeMovieState>(
      'should change state to loading when usecase is called',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((realInvocation) async => Right(tMovieList));
        return moviesCubit;
      },
      act: (bloc) {
        bloc.fetchPopularMovies();
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <HomeMovieState>[
        HomeMoviePopularLoading(),
        HomeMoviePopularHasData(movies: tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<HomeMovieCubit, HomeMovieState>(
      'should return error when data is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer((realInvocation) async =>
        const Left(ServerFailure('Server Failure')));
        return moviesCubit;
      },
      act: (bloc) {
        bloc.fetchPopularMovies();
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <HomeMovieState>[
        HomeMoviePopularLoading(),
        const HomeMoviePopularError(message: 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}
