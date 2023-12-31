import 'package:ditonton/presentation/bloc/tvseries/toprated/top_rated_tv_series_cubit.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvSeriesPage extends StatelessWidget {
  static const routeName = '/top-rated-tv-series';

  const TopRatedTvSeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
          builder: (context, state) {
            switch (state.status) {
              case TopRatedTvSeriesStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case TopRatedTvSeriesStatus.error:
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              case TopRatedTvSeriesStatus.hasData:
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tvSeries = state.tvSeries[index];
                    return TvSeriesCard(tvSeries: tvSeries);
                  },
                  itemCount: state.tvSeries.length,
                );
            }
          },
        ),
      ),
    );
  }
}
