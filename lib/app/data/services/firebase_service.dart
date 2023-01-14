import 'package:bluetoothapp/app/data/helpers/firebase_helpers.dart';
import 'package:bluetoothapp/app/data/helpers/getstorage_helpers.dart';
import 'package:bluetoothapp/app/data/models/gas_model.dart';
import 'package:bluetoothapp/app/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
//to check whether user is avialable in the firestore
  static Future<bool> checkWhetherUserNameIsThere() async {
    String uid = UserModel.uid;
    return await FirebaseHelpers.checkIfDocExists("users", uid);
  }


  static Future<void> initializeUser()async{
    await FirebaseHelpers.readDoc("users/${UserModel.uid}").then((value){
       Gases.gasList = (value.get("gases") as List<dynamic>).cast<String>().map((macAddress) => Gas(macAddress)).toList();
       print(Gases.gasList);
    });
    
  }

  static Future<bool> removeGasFromUser(String gasId) async{
    
    return await FirebaseHelpers.removeDataFromArray("users/${UserModel.uid}", "gases", gasId);
  }

  static Future<void> addUser() async {
    String uid = UserModel.uid;
    
    Map<String, dynamic> data = {"userName": UserModel.userName,"gases":[]};
    await FirebaseHelpers.addOnFirestore("users/$uid", data);
    GetStorageHelpers.addKeyToLocalStorage("id", uid);
  }


  //To Add Gases to users field on firestore
  static Future<bool> addGas(String gasId) async{
   return await FirebaseHelpers.addElemetstoAnArray("users/${UserModel.uid}","gases",gasId);
  }


  static Future<bool> checkWhetherGasIsAvailable(String qrCodeResp) async{
    return FirebaseHelpers.checkIfDocExists("gases", qrCodeResp);
  }

  static Future<void> readGasLevel() async{
     await FirebaseFirestore.instance
    .collection("gases")
    .doc(Gases.activeGas!.macAddress)
    .get()
    .then((value) {        
      Gases.activeGas!.gasLevel = (value.data()!["gasLevel"]) as double;
     
    });
  }

  static Future<void> readLeakageLevel() async{
     await FirebaseFirestore.instance
    .collection("gases")
    .doc(Gases.activeGas!.macAddress)
    .get()
    .then((value) {        
      Gases.activeGas!.leakageLevel = (value.data()!["leakagelevel"]) as double;
    
    });
  }


}
