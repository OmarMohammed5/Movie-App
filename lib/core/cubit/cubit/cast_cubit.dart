import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviee_app/core/api/api_consumer.dart';
import 'package:moviee_app/core/errors/exceptions.dart';
import 'package:moviee_app/core/models/cast_model.dart';

part 'cast_state.dart';

class CastCubit extends Cubit<CastState> {
  CastCubit(this.api) : super(CastInitial());

  final ApiConsumer api;
  final String apiKey = "ae4d10cfad37d9846ffed212ea75dbc0";

  /// get movies cast
  getCastMovies(int movieId) async {
    emit(CastLoading());
    try {
      final response = await api.get(
        "https://api.themoviedb.org/3/movie/$movieId/credits?language=en-US&api_key=$apiKey",
      );
      final cast = (response['cast'] as List)
          .map((json) => CastModel.from(json))
          .toList();
      emit(CastLoaded(cast));
    } on ServerException catch (e) {
      emit(CastError(e.errorModel.errorMessage));
    } catch (e) {
      emit(CastError("Network Connection Error"));
    }
  }
}
