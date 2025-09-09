import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviee_app/core/api/api_consumer.dart';
import 'package:moviee_app/core/errors/exceptions.dart';
import 'package:moviee_app/models/movie_model.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit(this.api) : super(MovieDetailsInitial());

  final ApiConsumer api;
  final String apiKey = "ae4d10cfad37d9846ffed212ea75dbc0";

  Future<void> getDetailsMovie(int movieId) async {
    emit(MovieDetailsLoading());
    try {
      final response = await api.get(
        "https://api.themoviedb.org/3/movie/$movieId?language=en-US&api_key=$apiKey",
      );
      final movie = MovieModel.from(response);
      emit(MovieDetailsLoaded(movie));
    } on ServerException catch (e) {
      emit(MovieDetailsError(e.errorModel.errorMessage));
    } catch (e) {
      emit(MovieDetailsError("Network Connection Error"));
    }
  }
}
