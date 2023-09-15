import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_state.dart';

class TvSeriesDetailCubit extends Cubit<TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;

  TvSeriesDetailCubit({
    required this.getTvSeriesDetail,
  }) : super(TvSeriesDetailInitial());

  Future<void> fetchTvSeriesDetail(int id) async {
    emit(TvSeriesDetailLoading());

    final detailResult = await getTvSeriesDetail.execute(id);

    detailResult.fold(
      (failure) {
        emit(TvSeriesDetailError(message: failure.message));
      },
      (series) {
        emit(TvSeriesDetailHasData(detail: series));
      },
    );
  }
}
