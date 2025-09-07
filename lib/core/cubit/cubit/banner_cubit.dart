import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviee_app/core/api/api_consumer.dart';
import 'package:moviee_app/core/errors/exceptions.dart';
import 'package:moviee_app/models/banner_model.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit(this.api) : super(BannerInitial());

  final ApiConsumer api;

  final String apiKey = "ae4d10cfad37d9846ffed212ea75dbc0";
  fetchBanners() async {
    emit(BannerLoading());
    try {
      final response = await api.get(
        "https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1&api_key=$apiKey",
      );

      final List results = response['results'];
      final banners = results.map((json) => BannerModel.from(json)).toList();
      emit(BannerLoaded(banners));
    } on ServerException catch (e) {
      emit(BannerError(e.errorModel.errorMessage));
    } catch (e) {
      emit(BannerError("Network Connection Error"));
    }
  }
}
