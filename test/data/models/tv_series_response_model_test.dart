import 'dart:convert';

import 'package:ditonton/data/models/tvseries/tv_series_model.dart';
import 'package:ditonton/data/models/tvseries/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    backdropPath: "/hH4YaZuH89Hlyz0DEkf362Mj8gU.jpg",
    genreIds: [35],
    id: 65701,
    overview:
        "Two \"Internetainers\" (Rhett & Link) go far out and do the weirdest  things, giving you a daily dose of casual comedy every Monday-Friday.",
    popularity: 4584.564,
    posterPath: "/2Fja87aTeuXxTEI1MH2IuHHSsLq.jpg",
    voteAverage: 7.1,
    voteCount: 41,
    firstAirDate: '2012-01-09',
    name: 'Good Mythical Morning',
    originCountry: ["US"],
    originalLanguage: 'en',
    originalName: 'Good Mythical Morning',
  );

  const tTvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series_list_test.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/hH4YaZuH89Hlyz0DEkf362Mj8gU.jpg",
            "genre_ids": [35],
            "id": 65701,
            "overview":
                "Two \"Internetainers\" (Rhett & Link) go far out and do the weirdest  things, giving you a daily dose of casual comedy every Monday-Friday.",
            "popularity": 4584.564,
            "poster_path": "/2Fja87aTeuXxTEI1MH2IuHHSsLq.jpg",
            "vote_average": 7.1,
            "vote_count": 41,
            'first_air_date': '2012-01-09',
            "name": "Good Mythical Morning",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Good Mythical Morning"
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
