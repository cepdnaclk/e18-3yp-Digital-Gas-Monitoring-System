import 'package:bluetoothapp/app/components/gas_container.dart';
import 'package:bluetoothapp/app/components/home_container.dart';
import 'package:bluetoothapp/app/data/models/user_model.dart';
import 'package:bluetoothapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final controller1 =
      Get.put(HomeController(label: "controller1"), tag: "controller1");
  final controller2 =
      Get.put(HomeController(label: "controller2"), tag: "controller2");
  

  final List<String> imageList = [
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
  ];

  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    
    return Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          actions: [
          
          ],
          backgroundColor: Colors.teal,
        ),
        drawer: GFDrawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              GFDrawerHeader(
                currentAccountPicture: GFAvatar(
                  radius: 80.0,
                  backgroundImage: NetworkImage(
                      "https://robohash.org/2e1d8c12493ba12bc0eba06ef2cdb34e?set=set4&bgset=bg1&size=200x200"),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(UserModel.userName??""),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit / Add Gas'),
                onTap: (){
                  Get.to(Routes.EDIT_GAS);
                },
              ),
              ListTile(
                title: Text(''),
                onTap: null,
              ),
            ],
          ),
        ),
        body: VStack([
           Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Obx(() {
                 
                  return DropdownButton(
                    hint: Text("Select an option"),
                    value: controller1.selectedOption.value,
                    items: controller1.options.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String ? value) {
                      print(value);
                      controller1.selectedOption.value = value!;
                    },
                  );
                }),
              ),
            ),
           
          ],
        ),),
            
          makeCard(controller1).elevation(20).withRounded(value: 10).make(),
          // TODO: Add up your widgets
          GFItemsCarousel(
            rowCount: 3,
            children: [
              carouselSimpleCard().elevation(20).withRounded().make(),
              carouselSimpleCard().elevation(20).withRounded().make(),
              carouselSimpleCard().elevation(20).withRounded().make(),
            ],
          ),

          makeCard(controller2).elevation(20).withRounded(value: 10).make(),
        ])

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

  VxCard carouselSimpleCard() {
    return VxCard(VxBox(
        child: VStack(
      [
        Expanded(
          child: Center(
              child: VxCircle(
            child: Center(child: "3".text.xl4.make()),
            border: Border.all(color: Colors.red),
            radius: 100,
            backgroundColor: Colors.white,
          )),
        ),
        "Active Gases".text.make()
      ],
      crossAlignment: CrossAxisAlignment.center,
    )).makeCentered());
  }

  VxCard makeCard(HomeController controller) {
    double width = Get.width;
    double height = Get.height;

    return VxCard(VxBox(
      child: HStack(
        [
          Image.asset(
              "assets/images/${controller.label == "controller1" ? controller.image1 : controller.image2}",
              width: width * 0.55,
              fit: BoxFit.fill),
          Expanded(
            child: FutureBuilder(
                future: (controller.label == "controller1")
                    ? controller.readGasLevel()
                    : controller.readLeakageLevel(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return VStack([
                      Expanded(
                          child: (snapshot.data.toString())
                              .text
                              .size(50)
                              .fontWeight(FontWeight.w500)
                              .makeCentered()),
                      HStack(
                        [
                          Text("Happy"),
                          GFButton(
                            onPressed: () {},
                            icon: Icon(Icons.menu),
                            child: "more".text.black.make(),
                            color: Color(0xfffdf4ad),
                          )
                        ],
                        alignment: MainAxisAlignment.spaceBetween,
                        axisSize: MainAxisSize.max,
                      ),
                    ], crossAlignment: CrossAxisAlignment.center)
                        .paddingOnly(right: 10);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          )
        ],
        crossAlignment: CrossAxisAlignment.stretch,
      ),
    ).height(height * 0.2).width(double.infinity).make());
  }

  itemGridView(HomeController controller) {
    print(
        "..............Item Grid View passed with ${controller.label}.............");
    return FutureBuilder<String>(
        future: (controller.label == "controller1"
            ? controller.readGasLevel()
            : controller.readLeakageLevel()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: (controller.label == "controller1"
                  ? controller.onTap1
                  : controller.onTap2),
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/level_showing.png"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.teal.withOpacity(0.4), BlendMode.dstATop)),
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: (controller.label == "controller1"
                            ? controller.color1
                            : controller.color2),
                        width: 10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(5.0, 5.0),
                          blurRadius: 10.0)
                    ]),
                child: VStack(
                  [
                    (snapshot.data.toString()).text.size(60).make(),
                    (controller.label == "controller1"
                            ? controller.title1
                            : controller.title2)
                        .text
                        .semiBold
                        .make()
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
