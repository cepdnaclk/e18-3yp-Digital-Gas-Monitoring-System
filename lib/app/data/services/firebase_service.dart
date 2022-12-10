import 'package:bluetoothapp/app/data/helpers/firebase_helpers.dart';
import 'package:bluetoothapp/app/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {

//to check whether user is avialable in the firestore
static Future<bool> checkWhetherUserNameIsThere()async{
      String uid = UserModel.uid!;
      return await FirebaseHelpers.checkIfDocExists("users", uid);    
  }

static Future<void> addUser() async{
      String uid = UserModel.uid!;
      Map<String,dynamic> data = {"userName":"Vilakshan"};
      await FirebaseHelpers.addOnFirestore("users",uid,data);
}

  
  
}