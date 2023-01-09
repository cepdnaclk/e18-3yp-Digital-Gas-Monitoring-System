

import 'package:bluetoothapp/app/components/gas_container.dart';
import 'package:bluetoothapp/app/components/home_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final controller1 = Get.put(HomeController(label: "controller1"),tag: "controller1");
  final controller2 = Get.put(HomeController(label: "controller2"),tag: "controller2");


  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('Gas 1'),
        backgroundColor: Colors.teal,
      ),
      body: 
      VStack(
        [
          // TODO: Add up your widgets
          makeCard(controller1).elevation(20).withRounded(value: 10).make(),
           makeCard(controller2).elevation(20).withRounded(value: 10).make(),
        ]
      )

    //    GridView.count(
    //     crossAxisCount: 2,
    //     children: [
    //       itemGridView(Get.find<HomeController>(tag: "controller1")),
    //       itemGridView(Get.find<HomeController>(tag: "controller2")),
         
    //     ],

    //   // drawer: Drawer(
    //   //   child: ListView(
    //   //     // Important: Remove any padding from the ListView.
    //   //     padding: EdgeInsets.zero,
    //   //     children: [
    //   //       DrawerHeader(
    //   //         decoration: BoxDecoration(
    //   //           color: Colors.teal,
    //   //         ),
    //   //         child: Column(
    //   //           crossAxisAlignment: CrossAxisAlignment.center,
    //   //           mainAxisAlignment: MainAxisAlignment.center,
    //   //           children: const [
    //   //             Padding(
    //   //               padding: EdgeInsets.all(8.0),
    //   //               child: ProfilePicture(
    //   //                 name: 'Vilakshan',
    //   //                 radius: 25,
    //   //                 fontsize: 20,
    //   //                 tooltip: true,
    //   //                 img:
    //   //                     'https://avatars.githubusercontent.com/u/73380111?v=4',
    //   //               ),
    //   //             ),
    //   //             Text(
    //   //               'Available devices',
    //   //               style: TextStyle(color: Colors.white, fontSize: 20),
    //   //             ),
    //   //           ],
    //   //         ),
    //   //       ),
    //   //       ListTile(
    //   //         title: const Text('Gas 1'),
    //   //         onTap: () {
    //   //           Navigator.pop(context);
    //   //         },
    //   //       ),
    //   //       ListTile(
    //   //         title: const Text('Gas 2'),
    //   //         onTap: () {
    //   //           Navigator.pop(context);
    //   //         },
    //   //       ),
    //   //     ],
    //   //   ),

    //   // ),
    //   // body: ListView(children: [
    //   //   Container(
    //   //     child: Column(
    //   //       children: [
    //   //         Row(
    //   //           //padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    //   //           mainAxisAlignment: MainAxisAlignment.center,
    //   //           children: [
    //   //             GasContainer(
    //   //                 width: width / 3,
    //   //                 widget: itemGridView(
    //   //                     controller.readGasLevel(), "Gas Level Indicator"),
    //   //                 text: 'Gas Level Indicator'),
    //   //             GasContainer(
    //   //                 width: width / 3,
    //   //                 widget: itemGridView(
    //   //                     controller.readGasLevel(), "Gas Leakage Indicator"),
    //   //                 text: 'Gas Leakage Indicator'),
    //   //           ],
    //   //         ),
    //   //         HomeContainer(
    //   //           image: Image.asset(
    //   //             'assets/images/analysis.jpg',
    //   //           ),
    //   //           text: 'Usage Analysis',
    //   //           onTap: () {
    //   //             debugPrint("Analysisi tapped!");
    //   //           },
    //   //         ),
    //   //         HomeContainer(
    //   //             image: Image.asset('assets/images/notes.jpg'),
    //   //             text: 'Notes',
    //   //             onTap: () {
    //   //               debugPrint("Notes tapped!");
    //   //             })
    //   //       ],
    //   //     ),
    //   //   ),
    //   // ]),
    // )
    
    
    
    );
  }

  VxCard makeCard(HomeController controller) {
    double width = Get.width;
    double height = Get.height;


    return VxCard(
      
      VxBox(
        child: HStack(
          [
            Image.asset("assets/images/${controller.label=="controller1"?controller.image1:controller.image2}",width: width*0.55,fit: BoxFit.fill),
            Expanded(
              child: FutureBuilder(
                future:(controller.label=="controller1")?controller.readGasLevel():controller.readLeakageLevel(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return VStack(
                    [
                      Expanded(child: (snapshot.data.toString()).text.size(50).fontWeight(FontWeight.w500).makeCentered()),
                      HStack(
                        [
                          Text("Happy"),
                          
                          GFButton(onPressed: (){},icon: Icon(Icons.menu),child: "more".text.black.make(),color: Color(0xfffdf4ad),)
                        ],
                        alignment: MainAxisAlignment.spaceBetween,axisSize: MainAxisSize.max,
                      ),
                    ],crossAlignment: CrossAxisAlignment.center
                  ).paddingOnly(right: 10);




                  }else{
                    return CircularProgressIndicator();
                  }
                  
                }
              ),
            )


          ],crossAlignment: CrossAxisAlignment.stretch,
        ),
      ).height(height*0.2).width(double.infinity).make()
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
                        image:DecorationImage(image: AssetImage("assets/images/level_showing.png"),fit: BoxFit.cover,colorFilter: ColorFilter.mode(Colors.teal.withOpacity(0.4), BlendMode.dstATop)),
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
                          (snapshot.data.toString()).text.size(60).make(),
                          (controller.label=="controller1"?controller.title1:controller.title2).text.semiBold.make()
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
