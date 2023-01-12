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
  //TODO: Implement HomeController
  final String label;

  HomeController({required this.label});
  double _gasLevel = 0;
  double _leakageLevel = 0;
  Color color1 = Colors.red;
  Color color2 = Colors.green;



  var selectedOption = "Gas 1".obs;
  List<String> options = ["Gas 1", "Gas 2", "Gas 3"];

  
  String title1 = "Gas Level";
  String title2 = "Gas Leakage Leve";


  String image1 = "gas_level.png";
  String image2 = "gas_leakage.png";



  void onTap1() {
    print(".......Gas Level Tapped.......");
    Get.toNamed(Routes.ANALYICS_DASHBOARD);
  }

  void onTap2() {
    print(".......Gas Leakage Level Tapped.......");

  }



  var avaiablityStatus = AvaiablityStatus.low.obs;
  

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    FirebaseFunctions functions = FirebaseFunctions.instance;
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
      // if(_gasLevel>60){
      //   avaiablityStatus.value = AvaiablityStatus.high;  
      //   color1 = Colors.green;

      // }else if(_gasLevel>20){
      //   avaiablityStatus.value = AvaiablityStatus.average;  
      //   color1= Color(Colors.yellow[400]!.value);
      // }

      return _gasLevel.toString();
      
  }


   Future<String> readLeakageLevel() async{
     print(".......Read Leakage Level value.......");
      await FirebaseServices.readLeakageLevel();
      _leakageLevel = Gases.activeGas!.leakageLevel;
      print(".......Leakage level value is ${  _leakageLevel}.......");
      //  if(_leakageLevel>60){
      //   avaiablityStatus.value = AvaiablityStatus.high;  
      //   color2 = Colors.red;

      // }else if(_leakageLevel>20){
      //   avaiablityStatus.value = AvaiablityStatus.average;  
      //   color2= Color(Colors.yellow[400]!.value);
      // }
     

      return  _leakageLevel.toString();
      
  }

  
}
