import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
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
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Auth error"));
    } catch (e) {
      emit(AuthError("Network Connection Error"));
    }
  }

  //// Logout
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
