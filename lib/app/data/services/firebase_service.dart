import 'package:bluetoothapp/app/data/helpers/firebase_helpers.dart';
import 'package:bluetoothapp/app/data/helpers/getstorage_helpers.dart';
import 'package:bluetoothapp/app/data/models/gas_model.dart';
import 'package:bluetoothapp/app/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
//to check whether user is avialable in the firestore
  static Future<bool> checkWhetherUserNameIsThere() async {
    String uid = UserModel.uid!;
    return await FirebaseHelpers.checkIfDocExists("users", uid);
  }

  static Future<void> addUser() async {
    String uid = UserModel.uid!;
    
    Map<String, dynamic> data = {"userName": UserModel.userName,"gases":[]};
    await FirebaseHelpers.addOnFirestore("users", uid, data);
    GetStorageHelpers.addKeyToLocalStorage("id", uid);
  }

  static Future<void> addGas() async{
     FirebaseFirestore.instance
    .collection("users")
    .doc("${UserModel.uid}")
    .get()
    .then((value) {  
      (value.data()!["gases"] as List<String>).forEach((element) {
          Gases.gasList.add(Gas(element));
       });
    });
  }


  static Future<bool> checkWhetherGasIsAvailable(String qrCodeResp) async{
    return FirebaseHelpers.checkIfDocExists("gases", qrCodeResp);
  }

  static Future<void> readGasLevel() async{
     FirebaseFirestore.instance
    .collection("gases")
    .doc(Gases.activeGas!.macAddress)
    .get()
    .then((value) {  
      Gases.activeGas!.gasLevel(value as double);
    });
  }


}
