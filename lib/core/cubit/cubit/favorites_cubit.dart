import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  User? get user => FirebaseAuth.instance.currentUser;

  /// Coming data from Firestore
  Future<void> fetchFavorites() async {
    if (user == null) {
      emit(FavoritesError("User not logged in"));
      return;
    }

    try {
      emit(FavoritesLoading());

      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("favorites")
          .get();

      final favorites = snapshot.docs.map((doc) => doc.data()).toList();

      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  //// Add movie to favourite
  Future<void> addFavorite(Map<String, dynamic> movie) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("favorites")
          .doc(movie['id'].toString())
          .set(movie);

      if (state is FavoritesLoaded) {
        final updated = List<Map<String, dynamic>>.from(
          (state as FavoritesLoaded).favorites,
        )..add(movie);
        emit(FavoritesLoaded(updated));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  //// toggle favourite icon
  Future<void> toggleFavorite(Map<String, dynamic> movie) async {
    if (user == null) {
      emit(FavoritesError("User not logged in"));
      return;
    }

    try {
      final docRef = FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("favorites")
          .doc(movie['id'].toString());

      final doc = await docRef.get();

      if (doc.exists) {
        await docRef.delete();

        if (state is FavoritesLoaded) {
          final updated = (state as FavoritesLoaded).favorites
              .where((fav) => fav['id'].toString() != movie['id'].toString())
              .toList();
          emit(FavoritesLoaded(updated));
        }
      } else {
        await docRef.set(movie);

        if (state is FavoritesLoaded) {
          final updated = List<Map<String, dynamic>>.from(
            (state as FavoritesLoaded).favorites,
          )..add(movie);
          emit(FavoritesLoaded(updated));
        }
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  /// check is movie == favourite or no
  bool isFavorite(String id) {
    if (state is FavoritesLoaded) {
      final favorites = (state as FavoritesLoaded).favorites;
      return favorites.any((fav) => fav['id'].toString() == id);
    }
    return false;
  }

  //// remove favourite
  Future<void> removeFavorite(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("favorites")
          .doc(id)
          .delete();

      if (state is FavoritesLoaded) {
        final updated = (state as FavoritesLoaded).favorites
            .where((fav) => fav['id'].toString() != id)
            .toList();
        emit(FavoritesLoaded(updated));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
