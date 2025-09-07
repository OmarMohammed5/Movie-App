import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviee_app/core/cubit/cubit/favorites_cubit.dart';
import 'package:moviee_app/core/cubit/cubit/profile_cubit.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    _checkCurrentUser();
  }

  void _checkCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emit(
        AuthLoaded(
          uid: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
        ),
      );
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(AuthLoading());

    try {
      // Create an Account
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      // Save data in  Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({
            "name": name.trim(),
            "email": email.trim(),
            "createdAt": DateTime.now(),
          });

      //return the data success
      emit(
        AuthLoaded(
          uid: userCredential.user!.uid,
          name: name.trim(),
          email: email.trim(),
        ),
      );
      await context.read<FavoritesCubit>().fetchFavorites();
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Auth error"));
    } catch (e) {
      emit(AuthError("Network Connection Error"));
    }
  }

  //// Logout
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    /// clear profile data
    context.read<ProfileCubit>().clearUserProfile();
    emit(AuthLoggedOut());
  }
}
