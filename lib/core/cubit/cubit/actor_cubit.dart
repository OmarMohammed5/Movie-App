import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviee_app/core/api/api_consumer.dart';
import 'package:moviee_app/core/errors/exceptions.dart';
import 'package:moviee_app/models/actor_model.dart';

part 'actor_state.dart';

class ActorCubit extends Cubit<ActorState> {
  ActorCubit(this.api) : super(ActorInitial());

  final ApiConsumer api;
  final String apiKey = "ae4d10cfad37d9846ffed212ea75dbc0";
  //// get actor profile
  getActorProfile(int actorId) async {
    emit(ActorLoading());
    try {
      final response = await api.get(
        "https://api.themoviedb.org/3/person/$actorId?api_key=$apiKey&language=en-US",
      );
      final actor = ActorModel.from(response);
      emit(ActorLoaded(actor));
    } on ServerException catch (e) {
      emit(ActorError(e.errorModel.errorMessage));
    } catch (e) {
      emit(ActorError("Network Connection Error"));
    }
  }
}
