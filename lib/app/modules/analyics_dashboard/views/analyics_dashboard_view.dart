import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/analyics_dashboard_controller.dart';

class AnalyicsDashboardView extends GetView<AnalyicsDashboardController> {
  const AnalyicsDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnalyicsDashboardView'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
                    child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries>[
                            StackedLineSeries<ChartSampleData, String>(
                                groupName: 'Group A',
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    useSeriesColor: true
                                ),
                                dataSource: controller.data1,
                                xValueMapper: (ChartSampleData data, _) => data.x,
                                yValueMapper: (ChartSampleData data, _) => data.y
                            ),
                            StackedLineSeries<ChartSampleData, String>(
                                groupName: 'Group B',
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    useSeriesColor: true
                                ),
                                dataSource: controller.data2,
                                xValueMapper: (ChartSampleData data, _) => data.x,
                                yValueMapper: (ChartSampleData data, _) => data.y
                            ),
                          
                        ]
                    )
                )   
      ),
    );
  }
}
