import 'dart:math';

import 'package:ecommerceadmin/widgets/barchart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RevenueChartWidget extends StatelessWidget {
  List<double>weeklySummary=[
    60.50,
    80.89,
    90.98,
    80.90,
    108.98,
    200.67,
    29.67

  ];
   RevenueChartWidget({super.key});
  

  @override
  Widget build(BuildContext context) {
    return  SizedBox(height: 250,child: BarChartWidget(weeklySummary: weeklySummary,));
    
  }
}