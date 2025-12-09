import 'package:firebase_auth/firebase_auth.dart';

void handelFirebaseSignupException(FirebaseAuthException e) {
  // ignore: unused_local_variable
  String errorMessage;

  switch (e.code) {
    case "weak-password":
      errorMessage = "Password is too weak, please use a stronger one.";
      break;
    case "email-already-in-use":
      errorMessage = "This email is already registered. Try logging in.";
      break;
    case "invalid-email":
      errorMessage = "The email address is not valid.";
      break;
    case "operation-not-allowed":
      errorMessage = "Email/password accounts are not enabled.";
      break;
    default:
      errorMessage = "Oops! Something went wrong. Please try again.";
  }
}

void handleFirebaseLoginException(FirebaseAuthException e) {
  // ignore: unused_local_variable
  String message;
  switch (e.code) {
    case "user-not-found":
      message = "No account found with this email.";
      break;
    case "wrong-password":
      message = "Incorrect password.";
      break;
    default:
      message = "Login failed. Please try again.";
  }
}
