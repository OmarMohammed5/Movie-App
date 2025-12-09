import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviee_app/core/api/api_consumer.dart';
import 'package:moviee_app/core/errors/exceptions.dart';
import 'package:moviee_app/core/models/movie_model.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit(this.api) : super(MovieInitial());

  final ApiConsumer api;

  final String apiKey = "ae4d10cfad37d9846ffed212ea75dbc0";

  /// get movie for Categories [ Action , Adventure , comedy , drama , ......]
  getMoviesByCategory(int genreId) async {
    emit(MovieLoading());
    try {
      final response = await api.get(
        "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&api_key=$apiKey&with_genres=$genreId",
      );
      final List results = response['results'];
      final movies = results.map((json) => MovieModel.from(json)).toList();
      emit(MovieLoaded(movies));
    } on ServerException catch (e) {
      emit(MovieError(e.errorModel.errorMessage));
    } catch (e) {
      emit(MovieError("Network Connection Error"));
    }
  }

  //// get All Movies
  getAllMovies() async {
    try {
      final response = await api.get(
        "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&api_key=$apiKey",
      );
      final List results = response['results'];
      final allMovies = results.map((json) => MovieModel.from(json)).toList();
      emit(MovieLoaded(allMovies));
    } on ServerException catch (e) {
      emit(MovieError(e.errorModel.errorMessage));
    } catch (e) {
      emit(MovieError("Network Connection Error"));
    }
  }
}
