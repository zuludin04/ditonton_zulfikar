import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movies/detail/movie_detail_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_cubit_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MovieDetailCubit movieCubit;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieCubit = MovieDetailCubit(getMovieDetail: mockGetMovieDetail);
  });

  const tId = 1;

  void arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => const Right(testMovieDetail));
  }

  test('initial state is PopularMoviesState.loading', () {
    expect(
      movieCubit.state,
      const MovieDetailState.loading(),
    );
  });

  group('Get Movie Detail', () {
    blocTest<MovieDetailCubit, MovieDetailState>(
      'should get data from usecase',
      build: () {
        arrangeUsecase();
        return movieCubit;
      },
      act: (bloc) {
        bloc.fetchMovieDetail(tId);
      },
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should change movie detail when data is gotten successfully',
      build: () {
        arrangeUsecase();
        return movieCubit;
      },
      act: (bloc) {
        bloc.fetchMovieDetail(tId);
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <MovieDetailState>[
        const MovieDetailState.hasData(testMovieDetail),
      ],
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should return error when get movie detail is unsuccessfully',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieCubit;
      },
      act: (bloc) {
        bloc.fetchMovieDetail(tId);
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <MovieDetailState>[
        const MovieDetailState.error('Server Failure'),
      ],
    );
  });
}
