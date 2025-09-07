// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:meta/meta.dart';

// part 'profile_state.dart';

// class ProfileCubit extends Cubit<ProfileState> {
//   ProfileCubit() : super(ProfileInitial());

//   void setProfile({
//     required String uid,
//     required String name,
//     required String email,
//   }) {
//     emit(ProfileLoaded(name: name, email: email));
//   }

//   Future<void> fetchUserData() async {
//     emit(ProfileLoading());
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         final doc = await FirebaseFirestore.instance
//             .collection("Users")
//             .doc(user.uid)
//             .get();

//         if (doc.exists) {
//           final data = doc.data()!;
//           emit(ProfileLoaded(name: data['name'], email: data['email']));
//         } else {
//           emit(ProfileError("No profile data found"));
//         }
//       } else {
//         emit(ProfileError("No user logged in"));
//       }
//     } catch (e) {
//       emit(ProfileError(e.toString()));
//     }
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> loadUserProfile() async {
    emit(ProfileLoading());
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        emit(ProfileError("User not logged in"));
        return;
      }

      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get();

      if (!doc.exists) {
        emit(ProfileError("User data not found"));
        return;
      }

      final data = doc.data()!;
      emit(ProfileLoaded(name: data["name"] ?? "", email: data["email"] ?? ""));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
