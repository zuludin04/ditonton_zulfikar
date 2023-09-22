import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movies/toprated/top_rated_movies_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesCubit moviesCubit;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    moviesCubit = TopRatedMoviesCubit(getTopRatedMovies: mockGetTopRatedMovies);
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

  test('initial state is TopRatedMoviesState.loading', () {
    expect(
      moviesCubit.state,
      const TopRatedMoviesState.loading(),
    );
  });

  blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
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
    expect: () => <TopRatedMoviesState>[
      TopRatedMoviesState.hasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
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
    expect: () => <TopRatedMoviesState>[
      const TopRatedMoviesState.error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
