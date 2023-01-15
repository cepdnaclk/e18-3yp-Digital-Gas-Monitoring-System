import 'package:bluetoothapp/app/data/models/gas_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:velocity_x/velocity_x.dart';

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
              GridView.count(
                crossAxisCount: 3, // number of columns
                children:
                    Gases.activeGas!.monthStats!.toJson().entries.map((e) {
                  double num =
                      ((e.value / Gases.activeGas!.gasWeight) as double);
                  int wholeNum = num.truncate();
                  double decimal = num - wholeNum;
                  List<HalfFilledIcon> icons = [];
                  for (var i = 0; i < wholeNum; i++) {
                    icons.add(HalfFilledIcon(1));
                  }

                  icons.add(HalfFilledIcon(decimal));
                  return Card(
                    child: Column(
                      children: <Widget>[
                        (e.key).text.xl2.make(), // key is the month name
                        GridView.count(crossAxisCount: 3,children: icons,shrinkWrap: true,)                       
                      ],
                    ),
                  );
                }).toList(),
              ),
              demoChart(),
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
                icon: ImageIcon(
                  AssetImage("assets/icons/week.png"),
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: ImageIcon(
                  AssetImage("assets/icons/month.png"),
                ),
              ),
            ],
            controller: controller.tabController));
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

class HalfFilledIcon extends StatelessWidget {
  final double fillPercent;

  HalfFilledIcon(this.fillPercent);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Icon(Icons.gas_meter, size: 35, color: Colors.grey),
        ClipRect(
          child: Align(
            alignment: Alignment.bottomCenter,
            heightFactor: fillPercent,
            child: Icon(Icons.gas_meter, size: 35, color: Color(0xff00acec)),
          ),
        ),
      ],
    );
  }
}
