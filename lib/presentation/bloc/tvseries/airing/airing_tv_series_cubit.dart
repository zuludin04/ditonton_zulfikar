import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_airing_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'airing_tv_series_state.dart';

class AiringTvSeriesCubit extends Cubit<AiringTvSeriesState> {
  final GetAiringTvSeries getAiringTvSeries;

  AiringTvSeriesCubit({required this.getAiringTvSeries})
      : super(AiringTvSeriesInitial());

  Future<void> fetchAiringTvSeries() async {
    emit(AiringTvSeriesLoading());

    final result = await getAiringTvSeries.execute();

    result.fold(
      (failure) {
        emit(AiringTvSeriesError(message: failure.message));
      },
      (seriesData) {
        emit(AiringTvSeriesHasData(tvSeries: seriesData));
      },
    );
  }
}
