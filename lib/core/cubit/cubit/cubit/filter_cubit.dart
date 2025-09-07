import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviee_app/models/movie_model.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterInitial());

  List<MovieModel> allMovies = [];

  /// Storage the list of movies when do search
  void setMovies(List<MovieModel> movies) {
    allMovies = movies;
    emit(FilterLoaded(movies));
  }

  //// Filter by Title
  void filterTitle() {
    final filtered = List<MovieModel>.from((allMovies));
    filtered.sort((a, b) => a.title.compareTo(b.title));
    emit(FilterLoaded(filtered));
  }

  //// Filter bt Rate
  void filterRate() {
    final filtered = List<MovieModel>.from(allMovies);
    filtered.sort((a, b) => b.voteAverage.compareTo(a.voteAverage));
    emit(FilterLoaded(filtered));
  }

  //// Clear Filter
  void reset() {
    emit(FilterLoaded(allMovies));
  }
}
