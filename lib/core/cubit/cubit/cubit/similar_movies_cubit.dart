import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviee_app/core/api/api_consumer.dart';
import 'package:moviee_app/core/errors/exceptions.dart';
import 'package:moviee_app/models/movie_model.dart';

part 'similar_movies_state.dart';

class SimilarMoviesCubit extends Cubit<SimilarMoviesState> {
  SimilarMoviesCubit(this.api) : super(SimilarMoviesInitial());

  final ApiConsumer api;
  final String apiKey = "ae4d10cfad37d9846ffed212ea75dbc0";
  //// get Similar Movies
  getSimilarMovies(int movieId) async {
    emit(SimilarMoviesLoading());
    try {
      final response = await api.get(
        "https://api.themoviedb.org/3/movie/$movieId/similar?language=en-US&page=1&api_key=$apiKey",
      );
      final List results = response['results'];
      final similarMovies = results
          .map((json) => MovieModel.from(json))
          .toList();
      emit(SimilarMoviesLoaded(similarMovies));
    } on ServerException catch (e) {
      emit(SimilarMoviesError(e.errorModel.errorMessage));
    } catch (e) {
      emit(SimilarMoviesError("Unexcpected Error"));
    }
  }
}
