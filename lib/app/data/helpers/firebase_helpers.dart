import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelpers{

  //to check whether the docs exists
  static Future<bool> checkIfDocExists(String colId , String docId) async {
  try {
    var collectionRef = FirebaseFirestore.instance.collection(colId);
    var doc = await collectionRef.doc(docId).get();
    return doc.exists;
  } catch (e) {
    return false;
  }
}

  static Future<void> addOnFirestore (String path,Map<String,dynamic> data) async {
    try {
    var collectionRef = FirebaseFirestore.instance.doc(path).set(data)
    .then((value) => print("Data Added Successfully"))
    .catchError((error) => print("Failed to add user: $error"));
  } catch (e) {
    throw e;
  }}


  static Future<DocumentSnapshot<Map<String, dynamic>>> readDoc(String path)async{
      return await FirebaseFirestore.instance.doc(path).get();
  }



  static Future<bool> addElemetstoAnArray (String path,String fieldname,data)async{
    return await FirebaseFirestore.instance
    .doc(path)
    .update({
      fieldname: FieldValue.arrayUnion([data])
    }).then((value) => true).onError((error, stackTrace) => false);

  }
  
  static Future<bool> removeDataFromArray(String path,String fieldname,String valueToBeRemoved) async{

 return await FirebaseFirestore.instance
    .doc(path)
    .update({
      fieldname : FieldValue.arrayRemove([valueToBeRemoved])
    }).then((value) {
      print("removing");
      return true;
    }).catchError((e)=>false);
}}