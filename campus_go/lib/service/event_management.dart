import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventManagement {
  final _eventCollection = FirebaseFirestore.instance.collection("events");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Map<String, dynamic>>> getAllPosts() async {
    List<Map<String, dynamic>> list = [];
    var snapshot = await _eventCollection.get();
    var docs = snapshot.docs;
    for (var i = 0; i < docs.length; i++) {
      var data = docs[i].data();
      list.add(data);
    }
    return list;
  }

  Future<String> addEvent(String title, String description, String profileURL,
      String location, String price, int maxParticipant, String date) async {
    List<Map<String, dynamic>> list = [];
    var docRef = _eventCollection.doc();
    var docID = docRef.id;
    try {
      await docRef.set({
        'title': title,
        'addedBy': _auth.currentUser!.uid,
        'price': price,
        'profileURL': profileURL,
        'location': location,
        'description': description,
        'activeParticipant': 0,
        'date': date,
        'maxParticipant': maxParticipant,
        'eventID': docID
      });
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Map<String, dynamic>>> getMostParticipatedEvents(
      int count) async {
    List<Map<String, dynamic>> list = [];
    var snapshot = await _eventCollection
        .orderBy("activeParticipant", descending: true)
        .get();
    var docs = snapshot.docs;
    for (var i = 0; i < count; i++) {
      var data = docs[i].data();
      list.add(data);
    }
    return list;
  }
}
