import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviee_app/core/api/dio_consumer.dart';
import 'package:moviee_app/core/cubit/cubit/actor_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/auth_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/bottom_nav_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/cast_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/cubit/actor_movies_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/cubit/filter_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/cubit/similar_movies_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/favorites_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/geners_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/movie_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/movie_details_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/movie_trailer_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/profile_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/search_movie_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/theme_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/top_movies_cubit.dart';
import 'package:moviee_app/splash/screen/splash.dart';
import 'package:moviee_app/theme/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TopMoviesCubit(DioConsumer(dio: Dio()))..fetchMovies(),
        ),
        BlocProvider(create: (_) => FavoritesCubit()..fetchFavorites()),
        BlocProvider(create: (_) => GenersCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (_) => MovieCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (_) => FilterCubit()),
        BlocProvider(create: (_) => MovieDetailsCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (_) => CastCubit(DioConsumer(dio: Dio()))),
        BlocProvider(
          create: (_) => SimilarMoviesCubit(DioConsumer(dio: Dio())),
        ),
        BlocProvider(create: (_) => ActorCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (_) => ActorMoviesCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (_) => MovieTrailerCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (_) => SearchMovieCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => BottomNavCubit()),
      ],
      child: MoviesApp(),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          home: const Splash(),
        );
      },
    );
  }
}
