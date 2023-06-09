import 'package:campus_go/service/user_management.dart';
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

  Future<Map<String, dynamic>?> getEventDataByID(String eventID) async {
    var docRef = await _eventCollection.doc(eventID).get();
    var data = docRef.data();

    return data;
  }

  Future<DocumentReference<Map<String, dynamic>>> getEventDocRefByID(
      String eventID) async {
    var docRef = await _eventCollection.doc(eventID);

    return docRef;
  }

  Future<String> deleteEvent(String eventID) async {
    var docRef = _eventCollection.doc(eventID);
    try {
      await docRef.delete();
      return 'Success';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<String> addEvent(
      String title,
      String description,
      String profileURL,
      String location,
      String price,
      int maxParticipant,
      String date,
      String phone) async {
    List<Map<String, dynamic>> list = [];
    var docRef = _eventCollection.doc();
    var docID = docRef.id;
    var user = await UserManagement().getCurrentUser();
    var name = user['name'];
    try {
      await docRef.set({
        'title': title,
        'name': name,
        'addedBy': _auth.currentUser!.uid,
        'price': price,
        'profileURL': profileURL,
        'location': location,
        'description': description,
        'activeParticipant': 0,
        'date': date,
        'maxParticipant': maxParticipant,
        'eventID': docID,
        'mail': _auth.currentUser!.email,
        'phone': phone,
        'participants': []
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
