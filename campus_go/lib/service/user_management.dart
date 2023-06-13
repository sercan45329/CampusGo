import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManagement {
  final _userCollection = FirebaseFirestore.instance.collection("users");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> getProfileURLByID(String userID) async {
    var snapshot =
        await _userCollection.where('userID', isEqualTo: userID).limit(1).get();
    var data = snapshot.docs.first.data();
    String url = data["profileURL"].toString();
    return url;
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    var snapshot = await _userCollection
        .where('userID', isEqualTo: _auth.currentUser!.uid)
        .limit(1)
        .get();
    var data = snapshot.docs.first.data();

    return data;
  }

  Future<String> updateProfileURLByID(String id, String url) async {
    try {
      var snapshot = await _userCollection.where("userID", isEqualTo: id).get();
      var docID = snapshot.docs.first.id;
      _userCollection.doc(docID).update({"profileURL": url});

      return "Success";
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<Map<String, dynamic>> getUserByID(String userID) async {
    var snapshot =
        await _userCollection.where('userID', isEqualTo: userID).limit(1).get();
    var data = snapshot.docs.first.data();

    return data;
  }

  String getCurrentUserID() {
    return _auth.currentUser!.uid;
  }

  String? getCurrentEmail() {
    return _auth.currentUser!.email;
  }
}
