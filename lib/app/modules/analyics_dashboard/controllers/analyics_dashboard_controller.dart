import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnalyicsDashboardController extends GetxController with GetSingleTickerProviderStateMixin{




  late TabController tabController;
  final data1= [
  ChartSampleData(x: 'Jan', y: 15, series: 'A'),
  ChartSampleData(x: 'Feb', y: 20, series: 'A'),
  ChartSampleData(x: 'Mar', y: 25, series: 'A'),
  
];

final data2= [
  ChartSampleData(x: 'Jan', y: 10),
  ChartSampleData(x: 'Feb', y: 30),
  ChartSampleData(x: 'Mar', y: 14),
  
];


  //TODO: Implement AnalyicsDashboardController


  

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}


class ChartSampleData {
  ChartSampleData({this.x, this.y, this.series});
  final String? x;
  final double? y;
  final String? series;
}