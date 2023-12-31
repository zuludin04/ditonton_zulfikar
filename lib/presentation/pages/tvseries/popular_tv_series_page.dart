import 'package:ditonton/presentation/bloc/tvseries/popular/popular_tv_series_cubit.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvSeriesPage extends StatelessWidget {
  static const routeName = '/popular-tv-series';

  const PopularTvSeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesCubit, PopularTvSeriesState>(
          builder: (context, state) {
            switch (state.status) {
              case PopularTvSeriesStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case PopularTvSeriesStatus.error:
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              case PopularTvSeriesStatus.hasData:
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
