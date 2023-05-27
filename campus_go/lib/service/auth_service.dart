import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> login(String email, String password) async {
    try {
      if (!email.contains("@edu.com.tr")) {
        return "Only students can login";
      }
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Login Successful";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return "Invalid Email";
        case "user-disable":
          return "User has been disabled";
        case "user-not-found":
          return "User not found";
        case "wrong-password":
          return "Wrong password";
      }
    }
    return "Something went wrong";
  }

  register() {}
}
