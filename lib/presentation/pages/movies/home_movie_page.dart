import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movies/home/home_movie_cubit.dart';
import 'package:ditonton/presentation/pages/movies/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movies/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HomeMovieCubit>().fetchNowPlayingMovies();
      context.read<HomeMovieCubit>().fetchPopularMovies();
      context.read<HomeMovieCubit>().fetchTopRatedMovies();
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
            Text('Now Playing', style: kHeading6),
            BlocBuilder<HomeMovieCubit, HomeMovieState>(
              buildWhen: (prev, current) {
                return current is HomeMovieNowPlayingHasData;
              },
              builder: (context, state) {
                if (state is HomeMovieNowPlayingLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeMovieNowPlayingHasData) {
                  return MovieList(movies: state.movies);
                } else if (state is HomeMovieNowPlayingError) {
                  return Text(state.message);
                } else {
                  return Container();
                }
              },
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.routeName),
            ),
            BlocBuilder<HomeMovieCubit, HomeMovieState>(
              buildWhen: (prev, current) {
                return current is HomeMoviePopularHasData;
              },
              builder: (context, state) {
                if (state is HomeMoviePopularLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeMoviePopularHasData) {
                  return MovieList(movies: state.movies);
                } else if (state is HomeMoviePopularError) {
                  return Text(state.message);
                } else {
                  return Container();
                }
              },
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
            ),
            BlocBuilder<HomeMovieCubit, HomeMovieState>(
              buildWhen: (prev, current) {
                return current is HomeMovieTopRatedHasData;
              },
              builder: (context, state) {
                if (state is HomeMovieTopRatedLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeMovieTopRatedHasData) {
                  return MovieList(movies: state.movies);
                } else if (state is HomeMovieTopRatedError) {
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

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
