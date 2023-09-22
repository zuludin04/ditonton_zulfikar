import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movies/detail/movie_detail_watchlist_cubit.dart';
import 'package:ditonton/presentation/bloc/movies/detail/movie_recommendations_cubit.dart';
import 'package:ditonton/presentation/pages/movies/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockMovieDetailWatchlistCubit extends MockCubit<MovieDetailWatchlistState>
    implements MovieDetailWatchlistCubit {}

class MockMovieRecommendationsCubit extends MockCubit<MovieRecommendationsState>
    implements MovieRecommendationsCubit {}

void main() {
  late MockMovieDetailWatchlistCubit mockWatchlistCubit;
  late MockMovieRecommendationsCubit mockRecommendationsCubit;

  setUp(() {
    mockWatchlistCubit = MockMovieDetailWatchlistCubit();
    mockRecommendationsCubit = MockMovieRecommendationsCubit();
  });

  Widget makeTestableWatchlistWidget(Widget body) {
    return BlocProvider<MovieDetailWatchlistCubit>.value(
      value: mockWatchlistCubit,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  Widget makeTestableRecommendationsWidget(Widget body) {
    return BlocProvider<MovieRecommendationsCubit>.value(
      value: mockRecommendationsCubit,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  group('movie detail watchlist test', () {
    testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
        when(() => mockWatchlistCubit.state)
            .thenReturn(const MovieDetailWatchlistState.watchlistStatus(false));

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(makeTestableWatchlistWidget(
            const MovieWatchlistButton(movie: testMovieDetail)));

        expect(watchlistButtonIcon, findsOneWidget);
      },
    );

    testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
        when(() => mockWatchlistCubit.state)
            .thenReturn(const MovieDetailWatchlistState.watchlistStatus(true));

        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(makeTestableWatchlistWidget(
            const MovieWatchlistButton(movie: testMovieDetail)));

        expect(watchlistButtonIcon, findsOneWidget);
      },
    );
  });

  group('movie detail recommendations test', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockRecommendationsCubit.state)
          .thenReturn(const MovieRecommendationsState.loading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableRecommendationsWidget(
          const MovieDetailRecommendations()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockRecommendationsCubit.state)
          .thenReturn(const MovieRecommendationsState.hasData(<Movie>[]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableRecommendationsWidget(
          const MovieDetailRecommendations()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockRecommendationsCubit.state)
          .thenReturn(const MovieRecommendationsState.error("Error message"));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableRecommendationsWidget(
          const MovieDetailRecommendations()));

      expect(textFinder, findsOneWidget);
    });
  });
}
