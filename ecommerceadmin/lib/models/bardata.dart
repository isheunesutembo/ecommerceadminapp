import 'package:ecommerceadmin/models/individualbar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  BarData(this.sunAmount, this.monAmount, this.tueAmount, this.wedAmount,
      this.thurAmount, this.friAmount, this.satAmount);
  List<IndividualBar> barData = [];
  void initializeBarData() {
    barData = [
      IndividualBar(x:0, y:sunAmount),
      IndividualBar(x: 1, y: monAmount),
      IndividualBar(x: 2, y: tueAmount),
      IndividualBar(x: 3, y: wedAmount),
      IndividualBar(x: 4, y: thurAmount),
      IndividualBar(x: 5, y: friAmount),
      IndividualBar(x: 6, y: satAmount)
    ];
  }
}
