import 'dart:io';

import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/source/movies/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/source/movies/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/source/tvseries/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/source/tvseries/tv_series_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/domain/usecases/get_airing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/remove_movies_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/save_movies_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies_tvseries.dart';
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
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // bloc movies
  locator.registerFactory(
    () => HomeMovieCubit(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(() => MovieDetailCubit(getMovieDetail: locator()));
  locator.registerFactory(
      () => MovieRecommendationsCubit(getMovieRecommendations: locator()));
  locator.registerFactory(
    () => MovieDetailWatchlistCubit(
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator
      .registerFactory(() => MovieTvSeriesSearchCubit(searchMovies: locator()));
  locator
      .registerFactory(() => PopularMoviesCubit(getPopularMovies: locator()));
  locator
      .registerFactory(() => TopRatedMoviesCubit(getTopRatedMovies: locator()));
  locator.registerFactory(
      () => WatchlistMovieCubit(getWatchlistMovies: locator()));

  // bloc tv series
  locator.registerFactory(
    () => HomeTvSeriesCubit(
      getAiringTvSeries: locator(),
      getPopularTvSeries: locator(),
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
      () => PopularTvSeriesCubit(getPopularTvSeries: locator()));
  locator.registerFactory(
      () => TopRatedTvSeriesCubit(getTopRatedTvSeries: locator()));
  locator
      .registerFactory(() => AiringTvSeriesCubit(getAiringTvSeries: locator()));
  locator.registerFactory(
      () => WatchlistTvSeriesCubit(getWatchlistTvSeries: locator()));
  locator
      .registerFactory(() => TvSeriesDetailCubit(getTvSeriesDetail: locator()));
  locator.registerFactory(() =>
      TvSeriesRecommendationsCubit(getTvSeriesRecommendations: locator()));
  locator.registerFactory(
    () => TvSeriesDetailWatchlistCubit(
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator
      .registerLazySingleton(() => SearchMoviesTvSeries(locator(), locator()));
  locator.registerLazySingleton(() => GetWatchListMoviesStatus(locator()));
  locator.registerLazySingleton(() => SaveMoviesWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveMoviesWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetAiringTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchListTvSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  final sslCert = await rootBundle.load('certificates/certificates.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

  HttpClient client = HttpClient(context: securityContext);
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;
  IOClient ioClient = IOClient(client);
  locator.registerLazySingleton(() => ioClient);
}
