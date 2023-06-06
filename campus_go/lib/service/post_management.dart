import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  Future<Color> checkIfLiked(String postID) async {
    var docRef = _postCollection.doc(postID);
    var snapshot = await docRef.get();
    var data = snapshot.data();
    var likelist = List.from(data!['likes']);
    if (!likelist.contains(_auth.currentUser!.uid)) {
      return Colors.white;
    } else {
      return Colors.green.shade600;
    }
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

  Future<void> increaseCommentNum(String postID) async {
    var docRef = _postCollection.doc(postID);
    await docRef.update({
      'commentNum': FieldValue.increment(1),
    });
  }

  Future<Map<String, dynamic>?> getPostByID(String postID) async {
    var docRef = await _postCollection.doc(postID).get();
    var data = docRef.data();

    return data;
  }

  Future<DocumentReference<Map<String, dynamic>>> getPostDocRefByID(
      String postID) async {
    var docRef = _postCollection.doc(postID);

    return docRef;
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
        'timestamp': FieldValue.serverTimestamp(),
        'likes': [],
        'postID': docID
      });
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }
}
