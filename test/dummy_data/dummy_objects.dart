import 'package:ditonton/data/models/watchlist_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTvSeries = TvSeries(
  backdropPath: "/hH4YaZuH89Hlyz0DEkf362Mj8gU.jpg",
  firstAirDate: "2012-01-09",
  genreIds: const [35],
  id: 65701,
  name: "Good Mythical Morning",
  originCountry: const ["US"],
  originalLanguage: "en",
  originalName: "Good Mythical Morning",
  overview:
      "Two \"Internetainers\" (Rhett & Link) go far out and do the weirdest  things, giving you a daily dose of casual comedy every Monday-Friday.",
  popularity: 4584.564,
  posterPath: "/2Fja87aTeuXxTEI1MH2IuHHSsLq.jpg",
  voteAverage: 7.1,
  voteCount: 41,
);

final testTvSeriesList = [testTvSeries];

const testTvSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  voteAverage: 1,
  voteCount: 1,
  originalTitle: 'title',
  releaseDate: 'firstAirDate',
  runtime: 22,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testWatchlistTable = WatchlistTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  type: 'tv_series',
);

final testWatchlistMap = {
  'id': 1,
  'title': 'title',
  'posterPath': 'posterPath',
  'overview': 'overview',
  'type': 'tv_series',
};
