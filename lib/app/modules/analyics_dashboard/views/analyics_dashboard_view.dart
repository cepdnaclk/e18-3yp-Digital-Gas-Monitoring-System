import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/analyics_dashboard_controller.dart';

class AnalyicsDashboardView extends GetView<AnalyicsDashboardController> {
  final controller = Get.put(AnalyicsDashboardController());
  AnalyicsDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: GFTabBarView(
            controller: controller.tabController,
            children: <Widget>[
              demoChart(),
               Container(
                child: Center(child: GFButton(onPressed: (){
                GFToast.showToast(
                  
                    'GetFlutter is an open source library that comes with pre-build 1000+ UI components.',
                    context,
                    
                    toastPosition: GFToastPosition.BOTTOM,
                    textStyle: TextStyle(fontSize: 16, color: GFColors.LIGHT),
                    backgroundColor: GFColors.DARK,
                    trailing: Icon(
                      Icons.notifications,
                      color: GFColors.SUCCESS,
                    ));
                })),
               )
              
            ],
          ),
        ),
        bottomNavigationBar: GFTabBar(
          tabBarColor: Color(0xff00acec),
          indicatorColor: Colors.white,
          indicatorWeight: 5,
          length: 2,
          tabs: <Widget>[
            Tab(
              icon: ImageIcon( AssetImage("assets/icons/week.png"), color: Colors.white,),
             
            ),
            Tab(
              icon: ImageIcon( AssetImage("assets/icons/month.png"), ),
              
            ),
           
          ],
          controller: controller.tabController
        ));
  }

  Container demoChart() {
    return Container(
        child: SfCartesianChart(
            plotAreaBackgroundColor: Colors.white,
            plotAreaBorderColor: Color(0xff00acec),
           
            enableAxisAnimation: true,
            primaryXAxis: CategoryAxis(),
            series: <ChartSeries>[
          StackedLineSeries<ChartSampleData, String>(
              groupName: 'Group A',
              dataLabelSettings:
                  DataLabelSettings(isVisible: true, useSeriesColor: true),
              dataSource: controller.data1,
              xValueMapper: (ChartSampleData data, _) => data.x,
              yValueMapper: (ChartSampleData data, _) => data.y,
              animationDuration: 2000),
          StackedLineSeries<ChartSampleData, String>(
              groupName: 'Group B',
              dataLabelSettings:
                  DataLabelSettings(isVisible: true, useSeriesColor: true),
              dataSource: controller.data2,
              xValueMapper: (ChartSampleData data, _) => data.x,
              yValueMapper: (ChartSampleData data, _) => data.y,
              animationDuration: 2000,
              animationDelay: 2000),
        ]));
  }
}
