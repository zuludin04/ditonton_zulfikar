// Mocks generated by Mockito 5.4.2 from annotations
// in ditonton/test/presentation/bloc/movie_tvseries_search_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i4;
import 'package:ditonton/common/failure.dart' as _i7;
import 'package:ditonton/domain/entities/search_result.dart' as _i8;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i2;
import 'package:ditonton/domain/repositories/tv_series_repository.dart' as _i3;
import 'package:ditonton/domain/usecases/search_movies_tvseries.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeMovieRepository_0 extends _i1.SmartFake
    implements _i2.MovieRepository {
  _FakeMovieRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvSeriesRepository_1 extends _i1.SmartFake
    implements _i3.TvSeriesRepository {
  _FakeTvSeriesRepository_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_2<L, R> extends _i1.SmartFake implements _i4.Either<L, R> {
  _FakeEither_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SearchMoviesTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchMoviesTvSeries extends _i1.Mock
    implements _i5.SearchMoviesTvSeries {
  MockSearchMoviesTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get movieRepository => (super.noSuchMethod(
        Invocation.getter(#movieRepository),
        returnValue: _FakeMovieRepository_0(
          this,
          Invocation.getter(#movieRepository),
        ),
      ) as _i2.MovieRepository);
  @override
  _i3.TvSeriesRepository get tvSeriesRepository => (super.noSuchMethod(
        Invocation.getter(#tvSeriesRepository),
        returnValue: _FakeTvSeriesRepository_1(
          this,
          Invocation.getter(#tvSeriesRepository),
        ),
      ) as _i3.TvSeriesRepository);
  @override
  _i6.Future<_i4.Either<_i7.Failure, List<_i8.SearchResult>>> execute(
    bool? searchMovie,
    String? query,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            searchMovie,
            query,
          ],
        ),
        returnValue:
            _i6.Future<_i4.Either<_i7.Failure, List<_i8.SearchResult>>>.value(
                _FakeEither_2<_i7.Failure, List<_i8.SearchResult>>(
          this,
          Invocation.method(
            #execute,
            [
              searchMovie,
              query,
            ],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.Failure, List<_i8.SearchResult>>>);
}
