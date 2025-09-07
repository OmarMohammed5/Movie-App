import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviee_app/core/api/api_consumer.dart';
import 'package:moviee_app/core/errors/exceptions.dart';
import 'package:moviee_app/models/movie_model.dart';

part 'search_movie_state.dart';

class SearchMovieCubit extends Cubit<SearchMovieState> {
  SearchMovieCubit(this.api) : super(SearchMovieInitial());

  final ApiConsumer api;
  final String apiKey = "ae4d10cfad37d9846ffed212ea75dbc0";

  String searchText = "";

  // ===== Add text to search field ======
  void setSearchText(String text) {
    searchText = text;
    if (text.isEmpty) {
      emit(SearchMovieInitial());
    }
  }

  // ====== Clear text of search field  ======
  void clearSearchText() {
    emit(SearchMovieEmpty());
  }

  //// search movie
  getSearchMovie(String query) async {
    emit(SearchMovieLoading());

    try {
      final response = await api.get(
        "https://api.themoviedb.org/3/search/movie?api_key=$apiKey&language=en-US&query=$query&page=1&include_adult=false",
      );
      final List results = response['results'];
      final movies = results
          .map<MovieModel>((json) => MovieModel.from(json))
          .toList();
      if (movies.isEmpty) {
        emit(SearchMovieEmpty());
      } else {
        emit(SearchMovieLoaded(movies));
      }
      (SearchMovieLoaded(movies));
    } on ServerException catch (e) {
      emit(SearchMovieError(e.errorModel.errorMessage));
    } catch (e) {
      emit(SearchMovieError("Unexpected Error"));
    }
  }
}
