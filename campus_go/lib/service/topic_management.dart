import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TopicManagement {
  final _topicCollection = FirebaseFirestore.instance.collection("topics");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Map<String, dynamic>>> getPopularTopics(int count) async {
    List<Map<String, dynamic>> list = [];
    var snapshot =
        await _topicCollection.orderBy("postNumber", descending: true).get();
    var docs = snapshot.docs;
    for (var i = 0; i < count; i++) {
      var data = docs[i].data();
      list.add(data);
    }
    return list;
  }
}
