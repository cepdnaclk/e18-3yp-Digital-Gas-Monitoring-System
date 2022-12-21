import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final controller1 = Get.put(HomeController(label: "controller1"),tag: "controller1");
  final controller2 = Get.put(HomeController(label: "controller2"),tag: "controller2");


  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          itemGridView(Get.find<HomeController>(tag: "controller1")),
          itemGridView(Get.find<HomeController>(tag: "controller2")),
         
        ],
      ),
    );
  }

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
 itemGridView(HomeController controller) {
   
    print("..............Item Grid View passed with ${controller.label}.............");
    return FutureBuilder<String>(
              future: (controller.label=="controller1"?controller.readGasLevel():controller.readLeakageLevel()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GestureDetector(
                    onTap: (controller.label=="controller1"?controller.onTap1:controller.onTap2),
                    child: Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color:(controller.label=="controller1" ?controller.color1:controller.color2), width: 10.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(5.0, 5.0),
                                blurRadius: 10.0)
                          ]),
                      child: VStack(
                        [
                          (snapshot.data.toString()).text.size(60).light.make(),
                          (controller.label=="controller1"?controller.title1:controller.title2).text.make()
                        ],
                        crossAlignment: CrossAxisAlignment.center,
                      ).centered(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("An error occurred: ${snapshot.error}");
                } else {
                  return CircularProgressIndicator();
                }
              });
      
  }
}
