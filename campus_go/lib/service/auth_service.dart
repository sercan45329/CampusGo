import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> login(String email, String password) async {
    try {
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

  Future<String> reauthenticate(AuthCredential credential) async {
    try {
      await _auth.currentUser!.reauthenticateWithCredential(credential);
      return "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return "Invalid Email";
        case "invalid-credential":
          return "Invalid Credential";
        case "user-mismatch":
          return "User mismatched";
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

  Future<String> updatePassword(String newPassword) async {
    try {
      await _auth.currentUser!.updatePassword(newPassword);
      return "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "weak-password":
          return "Weak Password";
      }
    }
    return "Something went wrong";
  }

  Future<String> updateMail(String newMail) async {
    try {
      await _auth.currentUser!.updateEmail(newMail);
      return "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return "Email already in use";
        case "invalid-email":
          return "Invalid mail";
        case "requires-recent-login":
          return "Requires recent login";
      }
    }
    return "Something went wrong";
  }

  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return "Success";
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<String?> register(
      String name, String mail, String password, String repassword) async {
    if (repassword != password) {
      return "Passwords do not match!";
    }

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: mail, password: password);
      try {
        await _firestore.collection("users").add({
          "email": mail,
          "password": password,
          "userID": credential.user!.uid,
          "profileURL":
              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
        });
      } on FirebaseAuthException catch (e) {
        print(e.code);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return "Email is already in use";
        case "invalid-email":
          return "Invalid Email";
        case "operation-not-allowed":
          return "Something went wrong";
        case "weak-password":
          return "Weak Password";
      }
    }
    return "Registration Successful";
  }

  Future<String?> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          return "User not found";
        case "invalid-email":
          return "Invalid Email";
        case "operation-not-allowed":
          return "Something went wrong";
        case "user-disable":
          return "User has been disabled";
      }
    }
    return "Mail sent to reset your password";
  }
}
