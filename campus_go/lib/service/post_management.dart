import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostManagement {
  final _postCollection = FirebaseFirestore.instance.collection("posts");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Map<String, dynamic>>> getMostLikedPosts(int count) async {
    List<Map<String, dynamic>> list = [];
    var snapshot =
        await _postCollection.orderBy("likeNum", descending: true).get();
    var docs = snapshot.docs;
    for (var i = 0; i < count; i++) {
      var data = docs[i].data();
      list.add(data);
    }
    return list;
  }

  Future<List<Map<String, dynamic>>> getAllPosts() async {
    List<Map<String, dynamic>> list = [];
    var snapshot = await _postCollection.get();
    var docs = snapshot.docs;
    for (var i = 0; i < docs.length; i++) {
      var data = docs[i].data();
      list.add(data);
    }
    return list;
  }

  Future<void> addTestPost() async {
    List<Map<String, dynamic>> list = [];
    var docRef = _postCollection.doc();
    var docID = docRef.id;
    await docRef.set({
      'title': 'Deneme baslık',
      'addedBy': _auth.currentUser!.uid,
      'category': 'Gaming',
      'likeNum': 0,
      'commentNum': 0,
      'description': 'deneme açıklama',
      'postID': docID
    });
  }

  Future<String> addPost(
      String title, String category, String description) async {
    List<Map<String, dynamic>> list = [];
    var docRef = _postCollection.doc();
    var docID = docRef.id;
    try {
      await docRef.set({
        'title': title,
        'addedBy': _auth.currentUser!.uid,
        'category': category,
        'likeNum': 0,
        'commentNum': 0,
        'description': description,
        'postID': docID
      });
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }
}
