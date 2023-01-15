import 'package:bluetoothapp/app/components/custom_dialog.dart';
import 'package:bluetoothapp/app/data/models/gas_model.dart';
import 'package:bluetoothapp/app/data/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/alert/gf_alert.dart';
import 'package:getwidget/getwidget.dart';
import 'package:velocity_x/velocity_x.dart';

class EditGasController extends GetxController {
  //TODO: Implement EditGasController
  final gasList = RxList<String>(Gases.macAddresses);
  
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void demoAlert(){
//    Get.dialog(
    
//   CustomDialog(),barrierColor: Colors.transparent,barrierDismissible: false
// );




  }

  void removeGas(int index)async{
   await FirebaseServices.removeGasFromUser(gasList[index]).then((value) {
Gases.macAddresses.removeAt(index);
gasList.removeAt(index);
   
    });
    
    
   
    
}
}

