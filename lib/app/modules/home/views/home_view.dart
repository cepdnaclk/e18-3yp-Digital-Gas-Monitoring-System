import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final controller = Get.find();
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
          GetBuilder<HomeController>(
              builder: (controller) {
                return FutureBuilder<double>(
                  future: controller.gasLevel,
                  builder: (context, snapshot) {
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue, width: 3.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(5.0, 5.0),
                                blurRadius: 10.0)
                          ]),
                      child: VStack(
                        [
                          (controller.gasLevel.toString()).text.size(60).light.make(),
                          "Gas Level Indicator".text.make()
                        ],
                        crossAlignment: CrossAxisAlignment.center,
                      ).centered(),
                    );
                  }
                );
              })
          // PhysicalModel(
          //   child: SizedBox(

          //     height: 100,
          //     width: 100,
          //     child: Center(
          //       child: VStack(
          //         [

          //           "24".text.size(80).light.makeCentered(),
          //           "Gas Level".text.size(10).makeCentered()
          //         ]
          //       ),
          //     ),
          //   ),

          //   shape: BoxShape.circle,
          //   elevation: 5,

          //   borderRadius: BorderRadius.circular(12.0),
          //   color: Colors.white,
          //   shadowColor: Colors.black,
          // ),
        ],
      ),
    );
  }
}
