import 'package:ecommerceadmin/models/bardata.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  final List weeklySummary;
  BarChartWidget({super.key, required this.weeklySummary});

  @override
  Widget build(BuildContext context) {
    BarData barData = BarData(
        weeklySummary[0],
        weeklySummary[1],
        weeklySummary[2],
        weeklySummary[3],
        weeklySummary[4],
        weeklySummary[5],
        weeklySummary[6]);
    barData.initializeBarData();
    return BarChart(
      BarChartData(
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(show: false),
          titlesData:const FlTitlesData(
              show: true,
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,getTitlesWidget: getBottomTitle))),

          maxY: 200,
          minY: 0,
          barGroups: barData.barData
              .map((data) => BarChartGroupData(x: data.x, barRods: [
                    BarChartRodData(
                        toY: data.y,
                        color: Colors.grey[600],
                        width: 30,
                        borderRadius: BorderRadius.circular(20),
                        backDrawRodData: BackgroundBarChartRodData(
                            show: true, toY: 100, color: Colors.grey[200]))
                  ]))
              .toList()),
    );
  }
}

Widget getBottomTitle(double value,TitleMeta meta){
  const style=TextStyle(color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 14);

  Widget text;
  switch(value.toInt()){
    case 0:
    text= Text("S",style: style,);
    break;
    case 1:
    text= Text("M",style: style,);
    break;
    case 2:
    text=Text("T",style: style,);
    break;
    case 3:
    text=Text("W",style: style,);
    break;
    case 4:
    text=Text("T",style: style,);
    break;
    case 5:
    text=Text("F",style: style,);
    break;
    case 6:
    text=Text("S",style: style,);
    break;
    default:
    text=Text("S",style: style,);
    break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
