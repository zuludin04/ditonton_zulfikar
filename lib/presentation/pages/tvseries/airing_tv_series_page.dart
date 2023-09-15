import 'package:ditonton/presentation/bloc/tvseries/airing/airing_tv_series_cubit.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiringTvSeriesPage extends StatefulWidget {
  static const routeName = '/airing-tv-series';

  const AiringTvSeriesPage({super.key});

  @override
  State<AiringTvSeriesPage> createState() => _AiringTvSeriesPageState();
}

class _AiringTvSeriesPageState extends State<AiringTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<AiringTvSeriesCubit>().fetchAiringTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AiringTvSeriesCubit, AiringTvSeriesState>(
          builder: (context, state) {
            if (state is AiringTvSeriesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AiringTvSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.tvSeries[index];
                  return TvSeriesCard(tvSeries: tvSeries);
                },
                itemCount: state.tvSeries.length,
              );
            } else if (state is AiringTvSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
