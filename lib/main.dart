import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/bloc/movie_tvseries_search_cubit.dart';
import 'package:ditonton/presentation/bloc/movies/detail/movie_detail_cubit.dart';
import 'package:ditonton/presentation/bloc/movies/detail/movie_detail_watchlist_cubit.dart';
import 'package:ditonton/presentation/bloc/movies/detail/movie_recommendations_cubit.dart';
import 'package:ditonton/presentation/bloc/movies/home/home_movie_cubit.dart';
import 'package:ditonton/presentation/bloc/movies/popular/popular_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/movies/toprated/top_rated_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/movies/watchlist/watchlist_movie_cubit.dart';
import 'package:ditonton/presentation/bloc/tvseries/airing/airing_tv_series_cubit.dart';
import 'package:ditonton/presentation/bloc/tvseries/detail/tv_series_detail_cubit.dart';
import 'package:ditonton/presentation/bloc/tvseries/detail/tv_series_detail_watchlist_cubit.dart';
import 'package:ditonton/presentation/bloc/tvseries/detail/tv_series_recommendations_cubit.dart';
import 'package:ditonton/presentation/bloc/tvseries/home/home_tv_series_cubit.dart';
import 'package:ditonton/presentation/bloc/tvseries/popular/popular_tv_series_cubit.dart';
import 'package:ditonton/presentation/bloc/tvseries/toprated/top_rated_tv_series_cubit.dart';
import 'package:ditonton/presentation/bloc/tvseries/watchlist/watchlist_tv_series_cubit.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/dashboard_page.dart';
import 'package:ditonton/presentation/pages/movies/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movies/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/tvseries/airing_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tvseries/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tvseries/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tvseries/tv_series_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<HomeTvSeriesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<AiringTvSeriesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvSeriesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvSeriesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvSeriesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<HomeMovieCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTvSeriesSearchCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const DashboardPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const DashboardPage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(
                builder: (_) => BlocProvider<PopularMoviesCubit>(
                  create: (context) =>
                      di.locator<PopularMoviesCubit>()..fetchPopularMovies(),
                  child: const PopularMoviesPage(),
                ),
              );
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(
                builder: (_) => BlocProvider<TopRatedMoviesCubit>(
                  create: (context) =>
                      di.locator<TopRatedMoviesCubit>()..fetchTopRatedMovies(),
                  child: const TopRatedMoviesPage(),
                ),
              );
            case AiringTvSeriesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const AiringTvSeriesPage());
            case TopRatedTvSeriesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedTvSeriesPage());
            case PopularTvSeriesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const PopularTvSeriesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (_) => di.locator<MovieDetailCubit>()),
                    BlocProvider(
                        create: (_) => di.locator<MovieRecommendationsCubit>()),
                    BlocProvider(
                        create: (_) => di.locator<MovieDetailWatchlistCubit>())
                  ],
                  child: MovieDetailPage(id: id),
                ),
                settings: settings,
              );
            case TvSeriesDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (_) => di.locator<TvSeriesDetailCubit>()),
                    BlocProvider(
                        create: (_) =>
                            di.locator<TvSeriesRecommendationsCubit>()),
                    BlocProvider(
                        create: (_) =>
                            di.locator<TvSeriesDetailWatchlistCubit>())
                  ],
                  child: TvSeriesDetailPage(id: id),
                ),
                settings: settings,
              );
            case SearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case WatchlistPage.routeName:
              return MaterialPageRoute(builder: (_) => const WatchlistPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
