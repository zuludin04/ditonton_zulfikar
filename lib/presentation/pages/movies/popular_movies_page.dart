import 'package:ditonton/presentation/bloc/movies/popular/popular_movies_cubit.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatelessWidget {
  static const routeName = '/popular-movie';

  const PopularMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular Movies')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
          builder: (context, state) {
            switch (state.status) {
              case PopularMoviesStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case PopularMoviesStatus.error:
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              case PopularMoviesStatus.hasData:
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
