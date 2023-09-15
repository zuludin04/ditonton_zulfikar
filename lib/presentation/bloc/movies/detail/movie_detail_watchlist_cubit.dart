import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies_status.dart';
import 'package:ditonton/domain/usecases/remove_movies_watchlist.dart';
import 'package:ditonton/domain/usecases/save_movies_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_watchlist_state.dart';

class MovieDetailWatchlistCubit extends Cubit<MovieDetailWatchlistState> {
  final GetWatchListMoviesStatus getWatchListStatus;
  final SaveMoviesWatchlist saveWatchlist;
  final RemoveMoviesWatchlist removeWatchlist;

  MovieDetailWatchlistCubit({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailWatchlistInitial());

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        emit(MovieDetailWatchlistChangeStatus(message: failure.message));
      },
      (successMessage) async {
        emit(MovieDetailWatchlistChangeStatus(message: successMessage));
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        emit(MovieDetailWatchlistChangeStatus(message: failure.message));
      },
      (successMessage) async {
        emit(MovieDetailWatchlistChangeStatus(message: successMessage));
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(MovieDetailWatchlistStatus(isWatchlist: result));
  }
}
