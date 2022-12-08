import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelpers{

  //to check whether the docs exists
  static Future<bool> checkIfDocExists(String colId , String docId) async {
  try {
    var collectionRef = FirebaseFirestore.instance.collection(colId);
    var doc = await collectionRef.doc(docId).get();
    return doc.exists;
  } catch (e) {
    throw e;
  }
}
}