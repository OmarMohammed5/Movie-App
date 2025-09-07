import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviee_app/core/api/api_consumer.dart';
import 'package:moviee_app/core/errors/exceptions.dart';
import 'package:moviee_app/models/movie_model.dart';

part 'top_movies_state.dart';

class TopMoviesCubit extends Cubit<TopMoviesState> {
  TopMoviesCubit(this.api) : super(TopMoviesInitial());

  final ApiConsumer api;

  //// get movie for Top 10 movies
  final String apiKey = "ae4d10cfad37d9846ffed212ea75dbc0";
  final String baseUrl = "https://api.themoviedb.org/3/movie/top_rated";
  fetchMovies() async {
    try {
      final response = await api.get(
        "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1&api_key=$apiKey",
      );

      final List results = response['results'];

      final movies = results.map((json) => MovieModel.from(json)).toList();
      emit(TopMoviesLoaded(movies));
    } on ServerException catch (e) {
      emit(TopMoviesError(e.errorModel.errorMessage));
    } catch (e) {
      emit(TopMoviesError("Unexpected error: $e"));
    }
  }
}
