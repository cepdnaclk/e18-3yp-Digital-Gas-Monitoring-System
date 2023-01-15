import 'package:bluetoothapp/app/data/models/gas_model.dart';
import 'package:bluetoothapp/app/data/services/firebase_service.dart';
import 'package:bluetoothapp/app/routes/app_pages.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AvaiablityStatus{
    low,average,high
}


class HomeController extends GetxController {
  

  Future<Gas>? gas;
  


  var macAddresses = Gases.macAddresses.obs;
  RxString activeGas = Gases.macAddresses[0].obs;
  onChange(String newValue) {
        activeGas.value = newValue;
        gas = FirebaseServices.readGas(newValue).then((value) {
          Gases.activeGas = value;
          return value;
        });
        
        update();
        
    }


  @override
  void onInit() async{
    super.onInit();
     gas = FirebaseServices.readGas(macAddresses[0]).then((value) {
          Gases.activeGas = value;
          return value;
        });
   
  }

 
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  

  
}
