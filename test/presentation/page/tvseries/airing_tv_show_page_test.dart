import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/tvseries/airing/airing_tv_series_cubit.dart';
import 'package:ditonton/presentation/pages/tvseries/airing_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAiringTvSeriesCubit extends MockCubit<AiringTvSeriesState>
    implements AiringTvSeriesCubit {}

void main() {
  late MockAiringTvSeriesCubit mockCubit;

  setUp(() {
    mockCubit = MockAiringTvSeriesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<AiringTvSeriesCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
    (WidgetTester tester) async {
      when(() => mockCubit.state)
          .thenReturn(const AiringTvSeriesState.loading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const AiringTvSeriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (WidgetTester tester) async {
      when(() => mockCubit.state)
          .thenReturn(const AiringTvSeriesState.hasData(<TvSeries>[]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(const AiringTvSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when Error',
    (WidgetTester tester) async {
      when(() => mockCubit.state)
          .thenReturn(const AiringTvSeriesState.error("Error Message"));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const AiringTvSeriesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
