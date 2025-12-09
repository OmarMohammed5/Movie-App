import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviee_app/core/api/api_consumer.dart';
import 'package:moviee_app/core/errors/exceptions.dart';
import 'package:moviee_app/core/models/actor_movie.dart';

part 'actor_movies_state.dart';

class ActorMoviesCubit extends Cubit<ActorMoviesState> {
  ActorMoviesCubit(this.api) : super(ActorMoviesInitial());

  final ApiConsumer api;
  final String apiKey = "ae4d10cfad37d9846ffed212ea75dbc0";

  /// get movies of actor
  getActorMovieCredits(int personId) async {
    emit(ActorMoviesLoading());

    try {
      final response = await api.get(
        "https://api.themoviedb.org/3/person/$personId/movie_credits?language=en-US&api_key=$apiKey",
      );

      final List cast = response['cast'];
      final movies = cast.map((json) => ActorMovieModel.from(json)).toList();
      movies.sort((a, b) {
        final aDate = a.date ?? "";
        final bDate = b.date ?? "";
        return bDate.compareTo(aDate);
      });
      emit(ActorMoviesLoaded(movies));
    } on ServerException catch (e) {
      emit(ActorMoviesError(e.errorModel.errorMessage));
    } catch (e) {
      emit(ActorMoviesError("Unexpected Error"));
    }
  }
}
