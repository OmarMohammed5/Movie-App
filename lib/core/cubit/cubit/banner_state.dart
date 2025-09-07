part of 'banner_cubit.dart';

@immutable
sealed class BannerState {}

final class BannerInitial extends BannerState {}

final class BannerLoading extends BannerState {}

final class BannerLoaded extends BannerState {
  final List<BannerModel> banners;

  BannerLoaded(this.banners);
}

final class BannerError extends BannerState {
  final String errorMessage;

  BannerError(this.errorMessage);
}
