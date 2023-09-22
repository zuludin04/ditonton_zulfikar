import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movies/detail/movie_recommendations_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_recommendations_cubit_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationsCubit movieCubit;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieCubit = MovieRecommendationsCubit(
      getMovieRecommendations: mockGetMovieRecommendations,
    );
  });

  const tId = 1;

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
  final tMovies = <Movie>[tMovie];

  void arrangeUsecase() {
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  test('initial state is PopularMoviesState.loading', () {
    expect(
      movieCubit.state,
      const MovieRecommendationsState.loading(),
    );
  });

  group('Get Movie Recommendations', () {
    blocTest<MovieRecommendationsCubit, MovieRecommendationsState>(
      'should get data from usecase',
      build: () {
        arrangeUsecase();
        return movieCubit;
      },
      act: (bloc) {
        bloc.fetchMovieRecommendations(tId);
      },
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieRecommendationsCubit, MovieRecommendationsState>(
      'should change movie recommendations when data is gotten successfully',
      build: () {
        arrangeUsecase();
        return movieCubit;
      },
      act: (bloc) {
        bloc.fetchMovieRecommendations(tId);
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <MovieRecommendationsState>[
        MovieRecommendationsState.hasData(tMovies),
      ],
    );

    blocTest<MovieRecommendationsCubit, MovieRecommendationsState>(
      'should change status when get movie detail is successfully but return error when data recommendations is unsuccessfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieCubit;
      },
      act: (bloc) {
        bloc.fetchMovieRecommendations(tId);
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <MovieRecommendationsState>[
        const MovieRecommendationsState.error('Server Failure'),
      ],
    );
  });
}
