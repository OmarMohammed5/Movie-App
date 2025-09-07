part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {
  final ThemeMode themeMode;
  const ThemeState(this.themeMode);
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial(super.themeMode);
}
