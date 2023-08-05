import 'package:ecommerceadmin/ui/productspage.dart';
import 'package:ecommerceadmin/widgets/homedashboardwidget.dart';
import 'package:ecommerceadmin/widgets/revenuechartwidget.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My Dashboard",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            HomeDashBoardWidget(),
            const SizedBox(
              height: 5,
            ),
          const  Center(
                child: Text(
              "Your Revenue",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: RevenueChartWidget(),
               )
          ],
        ),
      )),
    );
  }
}
