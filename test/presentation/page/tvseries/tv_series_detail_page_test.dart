import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/tvseries/detail/tv_series_detail_watchlist_cubit.dart';
import 'package:ditonton/presentation/bloc/tvseries/detail/tv_series_recommendations_cubit.dart';
import 'package:ditonton/presentation/pages/tvseries/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockTvSeriesDetailWatchlistCubit
    extends MockCubit<TvSeriesDetailWatchlistState>
    implements TvSeriesDetailWatchlistCubit {}

class MockTvSeriesRecommendationsCubit
    extends MockCubit<TvSeriesRecommendationsState>
    implements TvSeriesRecommendationsCubit {}

void main() {
  late MockTvSeriesDetailWatchlistCubit mockWatchlistCubit;
  late MockTvSeriesRecommendationsCubit mockRecommendationsCubit;

  setUp(() {
    mockWatchlistCubit = MockTvSeriesDetailWatchlistCubit();
    mockRecommendationsCubit = MockTvSeriesRecommendationsCubit();
  });

  Widget makeTestableWatchlistWidget(Widget body) {
    return BlocProvider<TvSeriesDetailWatchlistCubit>.value(
      value: mockWatchlistCubit,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  Widget makeTestableRecommendationsWidget(Widget body) {
    return BlocProvider<TvSeriesRecommendationsCubit>.value(
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
        when(() => mockWatchlistCubit.state).thenReturn(
            const TvSeriesDetailWatchlistState.watchlistStatus(false));

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(makeTestableWatchlistWidget(
            const TvSeriesWatchlistButton(tvSeries: testTvSeriesDetail)));

        expect(watchlistButtonIcon, findsOneWidget);
      },
    );

    testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
        when(() => mockWatchlistCubit.state).thenReturn(
            const TvSeriesDetailWatchlistState.watchlistStatus(true));

        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(makeTestableWatchlistWidget(
            const TvSeriesWatchlistButton(tvSeries: testTvSeriesDetail)));

        expect(watchlistButtonIcon, findsOneWidget);
      },
    );
  });

  group('movie detail recommendations test', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockRecommendationsCubit.state)
          .thenReturn(const TvSeriesRecommendationsState.loading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableRecommendationsWidget(
          const TvSeriesDetailRecommendations()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockRecommendationsCubit.state)
          .thenReturn(const TvSeriesRecommendationsState.hasData(<TvSeries>[]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableRecommendationsWidget(
          const TvSeriesDetailRecommendations()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockRecommendationsCubit.state).thenReturn(
          const TvSeriesRecommendationsState.error("Error message"));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableRecommendationsWidget(
          const TvSeriesDetailRecommendations()));

      expect(textFinder, findsOneWidget);
    });
  });
}
