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
          itemGridView(controller.readGasLevel(),"Gas Level Indicator"),
          itemGridView(controller.readLeakageLevel(),"Gas Leakage Indicator")
         
        ],
      ),
    );
  }

  GetBuilder<HomeController> itemGridView(Future<String>? funcController,String featureTitle) {
 
    return GetBuilder<HomeController>(builder: (_) {
          return FutureBuilder<String>(
              future: funcController,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color:(featureTitle=="Gas Level Indicator"?_.color1:_.color2), width: 10.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(5.0, 5.0),
                              blurRadius: 10.0)
                        ]),
                    child: VStack(
                      [
                        (snapshot.data.toString()).text.size(60).light.make(),
                        featureTitle.text.make()
                      ],
                      crossAlignment: CrossAxisAlignment.center,
                    ).centered(),
                  );
                } else if (snapshot.hasError) {
                  return Text("An error occurred: ${snapshot.error}");
                } else {
                  return CircularProgressIndicator();
                }
              });
        });
  }
}
