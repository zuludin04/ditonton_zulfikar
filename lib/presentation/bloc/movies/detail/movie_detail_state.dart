part of 'movie_detail_cubit.dart';

enum MovieDetailStatus { loading, error, hasData }

final class MovieDetailState extends Equatable {
  final MovieDetail? detail;
  final String message;
  final MovieDetailStatus status;

  const MovieDetailState._({
    this.detail,
    this.message = "",
    this.status = MovieDetailStatus.loading,
  });

  const MovieDetailState.loading() : this._();

  const MovieDetailState.hasData(MovieDetail detail)
      : this._(status: MovieDetailStatus.hasData, detail: detail);

  const MovieDetailState.error(String message)
      : this._(status: MovieDetailStatus.error, message: message);

  @override
  List<Object> get props => [message, status];
}
