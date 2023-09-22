import 'package:ditonton/presentation/bloc/tvseries/airing/airing_tv_series_cubit.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiringTvSeriesPage extends StatelessWidget {
  static const routeName = '/airing-tv-series';

  const AiringTvSeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Airing TV Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AiringTvSeriesCubit, AiringTvSeriesState>(
          builder: (context, state) {
            switch (state.status) {
              case AiringTvSeriesStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case AiringTvSeriesStatus.error:
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              case AiringTvSeriesStatus.hasData:
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
