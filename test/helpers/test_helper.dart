import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/source/movies/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/source/movies/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/source/tvseries/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/source/tvseries/tv_series_remote_data_source.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TvSeriesRepository,
  TvSeriesRemoteDataSource,
  TvSeriesLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}
