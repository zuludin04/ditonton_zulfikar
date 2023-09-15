import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/tvseries/home/home_tv_series_cubit.dart';
import 'package:ditonton/presentation/pages/tvseries/airing_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tvseries/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tvseries/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tvseries/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTvSeriesPage extends StatefulWidget {
  const HomeTvSeriesPage({super.key});

  @override
  State<HomeTvSeriesPage> createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HomeTvSeriesCubit>().fetchAiringTvSeries();
      context.read<HomeTvSeriesCubit>().fetchPopularMovies();
      context.read<HomeTvSeriesCubit>().fetchTopRatedMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeading(
              title: 'Airing',
              onTap: () =>
                  Navigator.pushNamed(context, AiringTvSeriesPage.routeName),
            ),
            BlocBuilder<HomeTvSeriesCubit, HomeTvSeriesState>(
              buildWhen: (prev, curr) => curr is HomeTvSeriesAiringHasData,
              builder: (context, state) {
                if (state is HomeTvSeriesAiringLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HomeTvSeriesAiringHasData) {
                  return TvSeriesList(tvSeries: state.tvSeries);
                } else if (state is HomeTvSeriesAiringError) {
                  return Text(state.message);
                } else {
                  return Container();
                }
              },
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvSeriesPage.routeName),
            ),
            BlocBuilder<HomeTvSeriesCubit, HomeTvSeriesState>(
              buildWhen: (prev, curr) => curr is HomeTvSeriesPopularHasData,
              builder: (context, state) {
                if (state is HomeTvSeriesPopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HomeTvSeriesPopularHasData) {
                  return TvSeriesList(tvSeries: state.tvSeries);
                } else if (state is HomeTvSeriesPopularError) {
                  return Text(state.message);
                } else {
                  return Container();
                }
              },
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvSeriesPage.routeName),
            ),
            BlocBuilder<HomeTvSeriesCubit, HomeTvSeriesState>(
              buildWhen: (prev, curr) => curr is HomeTvSeriesTopRatedHasData,
              builder: (context, state) {
                if (state is HomeTvSeriesTopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HomeTvSeriesTopRatedHasData) {
                  return TvSeriesList(tvSeries: state.tvSeries);
                } else if (state is HomeTvSeriesTopRatedError) {
                  return Text(state.message);
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  const TvSeriesList({super.key, required this.tvSeries});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.routeName,
                  arguments: series.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${series.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
