import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviee_app/core/api/api_consumer.dart';
import 'package:moviee_app/core/errors/exceptions.dart';
import 'package:moviee_app/core/models/gener_model.dart';

part 'geners_state.dart';

class GenersCubit extends Cubit<GenersState> {
  GenersCubit(this.api) : super(GenersInitial());

  final ApiConsumer api;
  int selectedIndex = 0;
  List<GenerModel> geners = [];
  final String apiKey = "ae4d10cfad37d9846ffed212ea75dbc0";
  //// fetchGeners
  fetchGeners() async {
    if (isClosed) return;
    emit(GenersLoading());
    try {
      final response = await api.get(
        "https://api.themoviedb.org/3/genre/movie/list?language=en&api_key=$apiKey",
      );
      final List results = response['genres'];
      geners = results.map((json) => GenerModel.from(json)).toList();
      emit(GenersLoaded(geners, selectedIndex));
    } on ServerException catch (e) {
      if (!isClosed) emit(GenersError(e.errorModel.errorMessage));
    } catch (e) {
      print("===== ========$e====================");
      if (!isClosed) emit(GenersError("Network Connection Error"));
    }
  }

  //// changeSelectedIndex
  void changeSelectedIndex(int index) {
    selectedIndex = index;
    emit(GenersLoaded(geners, selectedIndex));
  }
}
