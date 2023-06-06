import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentManagement {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getAllComments(String postID) async {
    var parentColRef = _db.collection('posts').doc(postID);
    var colRef = parentColRef.collection('comments');

    List<Map<String, dynamic>> list = [];
    var snapshot = await colRef.get();
    var docs = snapshot.docs;
    for (var i = 0; i < docs.length; i++) {
      var data = docs[i].data();
      list.add(data);
    }
    return list;
  }

  Future<String> addComment(
      String postID, String description, String name, String url) async {
    var parentColRef = _db.collection('posts').doc(postID);
    var colRef = parentColRef.collection('comments');
    var commentID = colRef.doc().id;
    try {
      await colRef.doc(commentID).set({
        'addedBy': _auth.currentUser!.uid,
        'author': name,
        'description': description,
        'commentID': commentID,
        'profileURL': url,
        'timestamp': FieldValue.serverTimestamp()
      });
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }
}
