import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviee_app/core/api/api_consumer.dart';
import 'package:moviee_app/core/errors/exceptions.dart';
import 'package:moviee_app/models/movie_triller.dart';

part 'movie_trailer_state.dart';

class MovieTrailerCubit extends Cubit<MovieTrailerState> {
  MovieTrailerCubit(this.api) : super(MovieTrailerInitial());

  final ApiConsumer api;
  final String apiKey = "ae4d10cfad37d9846ffed212ea75dbc0";

  /// fetchTrailer
  fetchTrailer(int movieId) async {
    emit(MovieTrailerLoading());
    try {
      final response = await api.get(
        "https://api.themoviedb.org/3/movie/$movieId/videos?language=en-US&api_key=$apiKey",
      );

      final data = response is Map<String, dynamic> ? response : response.data;

      final results = data["results"] as List<dynamic>;

      final trailers = results
          .map((json) => MovieTrailer.from(json))
          .where((video) => video.type == "Trailer" && video.site == "YouTube")
          .toList();

      if (trailers.isEmpty) {
        emit(MovieTrailerError("No YouTube trailer available for this movie"));
        return;
      }

      emit(MovieTrailerLoaded(trailers));
    } on ServerException catch (e) {
      emit(MovieTrailerError(e.errorModel.errorMessage));
    } catch (e) {
      // print("Error in fetchTrailer: $e");
      // print(stack);
      emit(MovieTrailerError("Unexpected error: $e"));
    }
  }
}
