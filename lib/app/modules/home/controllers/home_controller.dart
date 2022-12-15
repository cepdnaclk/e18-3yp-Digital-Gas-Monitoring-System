import 'package:bluetoothapp/app/data/models/gas_model.dart';
import 'package:bluetoothapp/app/data/services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

enum AvaiablityStatus{
    low,average,high
}

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final _gasLevel = Rx<double>(0);
  var avaiablityStatus = AvaiablityStatus.low.obs;
  double get gasLevel => _gasLevel.value;

  final count = 0.obs;
  @override
  void onInit() {
    readGasLevel();
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

  Future<void> readGasLevel() async{
      await FirebaseServices.readGasLevel();
      _gasLevel.value = Gases.activeGas!.gasLevel;
      if(_gasLevel>60){
        avaiablityStatus.value = AvaiablityStatus.high;  
      }else if(_gasLevel>20){
        avaiablityStatus.value = AvaiablityStatus.average;  
      }

      update();
      
      
  }

  
}
