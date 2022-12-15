import 'package:bluetoothapp/app/data/models/gas_model.dart';
import 'package:bluetoothapp/app/data/services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AvaiablityStatus{
    low,average,high
}


class HomeController extends GetxController {
  //TODO: Implement HomeController
  double _gasLevel = 0;
  double _leakageLevel = 0;
  Color color1 = Colors.red;
  Color color2 = Colors.red;
  
  var avaiablityStatus = AvaiablityStatus.low.obs;
  

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

  Future<String> readGasLevel() async{
     print(".......Read Gas Level value.......");
      await FirebaseServices.readGasLevel();
 print(".......Calling Getter Method.......");
      _gasLevel = Gases.activeGas!.gasLevel;
      print(".......Gas Level value is ${_gasLevel}.......");
      if(_gasLevel>60){
        avaiablityStatus.value = AvaiablityStatus.high;  
        color1 = Colors.green;

      }else if(_gasLevel>20){
        avaiablityStatus.value = AvaiablityStatus.average;  
        color1= Color(Colors.yellow[400]!.value);
      }

      return _gasLevel.toString();
      
  }


   Future<String> readLeakageLevel() async{
     print(".......Read Leakage Level value.......");
      await FirebaseServices.readLeakageLevel();
      _leakageLevel = Gases.activeGas!.leakageLevel;
      print(".......Leakage level value is ${  _leakageLevel}.......");
       if(_leakageLevel>60){
        avaiablityStatus.value = AvaiablityStatus.high;  
        color2 = Colors.green;

      }else if(_leakageLevel>20){
        avaiablityStatus.value = AvaiablityStatus.average;  
        color2= Color(Colors.yellow[400]!.value);
      }
     

      return  _leakageLevel.toString();
      
  }

  
}
