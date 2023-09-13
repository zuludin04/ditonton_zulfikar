import 'package:ditonton/presentation/pages/movies/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tvseries/watchlist_tv_series_page.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatelessWidget {
  static const routeName = '/watchlist';

  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Text('Movies')),
              Tab(icon: Text('TV Series')),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            WatchlistMoviesPage(),
            WatchlistTvSeriesPage(),
          ],
        ),
      ),
    );
  }
}
