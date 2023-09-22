import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/tvseries/detail/tv_series_detail_cubit.dart';
import 'package:ditonton/presentation/bloc/tvseries/detail/tv_series_detail_watchlist_cubit.dart';
import 'package:ditonton/presentation/bloc/tvseries/detail/tv_series_recommendations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const routeName = '/detail-tv-series';

  final int id;

  const TvSeriesDetailPage({super.key, required this.id});

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesDetailCubit>().fetchTvSeriesDetail(widget.id);
      context
          .read<TvSeriesDetailWatchlistCubit>()
          .loadWatchlistStatus(widget.id);
      context
          .read<TvSeriesRecommendationsCubit>()
          .fetchTvSeriesRecommendations(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeriesDetailCubit, TvSeriesDetailState>(
        builder: (context, state) {
          switch (state.status) {
            case TvSeriesDetailStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case TvSeriesDetailStatus.error:
              return Text(state.message);
            case TvSeriesDetailStatus.hasData:
              final tvSeries = state.detail;
              return SafeArea(child: DetailContent(tvSeries: tvSeries!));
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tvSeries;

  const DetailContent({super.key, required this.tvSeries});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeries.originalTitle,
                              style: kHeading5,
                            ),
                            TvSeriesWatchlistButton(tvSeries: tvSeries),
                            Text(_showGenres(tvSeries.genres)),
                            Text(_showDuration(tvSeries.runtime)),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeries.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text('Overview', style: kHeading6),
                            Text(tvSeries.overview),
                            const SizedBox(height: 16),
                            Text('Recommendations', style: kHeading6),
                            const TvSeriesDetailRecommendations(),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

class TvSeriesWatchlistButton extends StatelessWidget {
  final TvSeriesDetail tvSeries;

  const TvSeriesWatchlistButton({super.key, required this.tvSeries});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TvSeriesDetailWatchlistCubit,
        TvSeriesDetailWatchlistState>(
      listener: (context, state) {
        if (state.status ==
            TvSeriesDetailWatchlistStatus.changeWatchlistStatus) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () async {
            if (!state.isWatchlist) {
              await context
                  .read<TvSeriesDetailWatchlistCubit>()
                  .addWatchlist(tvSeries);
            } else {
              await context
                  .read<TvSeriesDetailWatchlistCubit>()
                  .removeFromWatchlist(tvSeries);
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              state.isWatchlist
                  ? const Icon(Icons.check)
                  : const Icon(Icons.add),
              const Text('Watchlist'),
            ],
          ),
        );
      },
    );
  }
}

class TvSeriesDetailRecommendations extends StatelessWidget {
  const TvSeriesDetailRecommendations({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSeriesRecommendationsCubit,
        TvSeriesRecommendationsState>(
      builder: (context, state) {
        switch (state.status) {
          case TvSeriesRecommendationsStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case TvSeriesRecommendationsStatus.error:
            return Text(key: const Key('error_message'), state.message);
          case TvSeriesRecommendationsStatus.empty:
            return const Text('Recommendation is Empty');
          case TvSeriesRecommendationsStatus.hasData:
            return SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final tvSeries = state.tvSeries[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          TvSeriesDetailPage.routeName,
                          arguments: tvSeries.id,
                        );
                      },
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: state.tvSeries.length,
              ),
            );
        }
      },
    );
  }
}
