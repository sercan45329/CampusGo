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

  Future<String> increasePostNumByCategory(String category) async {
    var result =
        await _topicCollection.where('title', isEqualTo: category).get();
    var docID = result.docs.first.id;
    try {
      await _topicCollection
          .doc(docID)
          .update({'postNumber': FieldValue.increment(1)});
      return 'Success';
    } on Exception catch (e) {
      return e.toString();
    }
  }
}
