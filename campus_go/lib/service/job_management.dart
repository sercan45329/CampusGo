import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobManagement {
  final _jobCollection = FirebaseFirestore.instance.collection("jobs");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> getJobByID(String jobID) async {
    var docRef = await _jobCollection.doc(jobID).get();
    var data = docRef.data();

    return data;
  }

  Future<DocumentReference<Map<String, dynamic>>> getJobDocRefByID(
      String jobID) async {
    var docRef = _jobCollection.doc(jobID);

    return docRef;
  }

  Future<String> addJobPosting(
      String companyName,
      String companyMail,
      String location,
      String whatLooking,
      String responsibilities,
      String requirements,
      String salaryType,
      String companyPhone,
      String jobFrequency,
      String jobTitle,
      String jobCategory) async {
    List<Map<String, dynamic>> list = [];
    var docRef = _jobCollection.doc();
    var docID = docRef.id;
    try {
      await docRef.set({
        'title': jobTitle,
        'company': companyName,
        'companyPhone': companyPhone,
        'mail': companyMail,
        'location': location,
        'category': jobCategory,
        'whatlooking': whatLooking,
        'responsibilities': responsibilities,
        'requirements': requirements,
        'dateCreated': FieldValue.serverTimestamp(),
        'salary': salaryType,
        'type': jobFrequency,
        'jobID': docID
      });
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Map<String, dynamic>>> getAllJobs() async {
    List<Map<String, dynamic>> list = [];
    var snapshot = await _jobCollection.get();
    var docs = snapshot.docs;
    if (snapshot.docs.isEmpty) {
      return list;
    }
    for (var i = 0; i < docs.length; i++) {
      var data = docs[i].data();
      list.add(data);
    }
    return list;
  }

  Future<String> updateJob(
      String jobID,
      String companyName,
      String companyMail,
      String location,
      String whatLooking,
      String responsibilities,
      String requirements,
      String salaryType,
      String companyPhone,
      String jobFrequency,
      String jobTitle,
      String jobCategory) async {
    var docRef = _jobCollection.doc(jobID);
    try {
      await docRef.update({
        'title': jobTitle,
        'company': companyName,
        'companyPhone': companyPhone,
        'mail': companyMail,
        'location': location,
        'category': jobCategory,
        'whatlooking': whatLooking,
        'responsibilities': responsibilities,
        'requirements': requirements,
        'salary': salaryType,
        'type': jobFrequency,
      });
      return 'Success';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<List<Map<String, dynamic>>> getRecentJobs(int count) async {
    List<Map<String, dynamic>> list = [];
    var snapshot =
        await _jobCollection.orderBy("dateCreated", descending: false).get();
    var docs = snapshot.docs;
    for (var i = 0; i < count; i++) {
      var data = docs[i].data();
      list.add(data);
    }
    return list;
  }

  Future<String> deleteJob(String jobID) async {
    var docRef = _jobCollection.doc(jobID);
    try {
      await docRef.delete();
      return 'Success';
    } on Exception catch (e) {
      return e.toString();
    }
  }
}
