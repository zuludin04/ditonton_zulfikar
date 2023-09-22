import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movies/popular/popular_movies_cubit.dart';
import 'package:ditonton/presentation/pages/movies/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularMoviesCubit extends MockCubit<PopularMoviesState>
    implements PopularMoviesCubit {}

void main() {
  late PopularMoviesCubit cubit;

  setUpAll(() {
    cubit = MockPopularMoviesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider.value(
        value: cubit,
        child: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => cubit.state).thenReturn(const PopularMoviesState.loading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => cubit.state)
        .thenReturn(const PopularMoviesState.hasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => cubit.state)
        .thenReturn(const PopularMoviesState.error("Error message"));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
