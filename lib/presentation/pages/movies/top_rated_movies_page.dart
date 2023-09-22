import 'package:ditonton/presentation/bloc/movies/toprated/top_rated_movies_cubit.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatelessWidget {
  static const routeName = '/top-rated-movie';

  const TopRatedMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Rated Movies')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesState>(
          builder: (context, state) {
            var status = state.status;
            switch (status) {
              case TopRatedMoviesStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case TopRatedMoviesStatus.error:
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              case TopRatedMoviesStatus.hasData:
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return MovieCard(movie: movie);
                  },
                  itemCount: state.movies.length,
                );
            }
          },
        ),
      ),
    );
  }
}
