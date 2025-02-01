import 'package:car_store/widget/LineChartForSales.dart';
import 'package:car_store/widget/PieChartCars.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticsPageAdminpanel extends StatelessWidget {
  const StatisticsPageAdminpanel({super.key});
  static String id = 'StatisticsPageAdminpanel';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text('Welcome.......',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 44),),
            SizedBox(height: 20,),
            const Text(
              'Pie Chart For Car',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60.0),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(width: 200, height: 200, child: AnimatedPieChart()),
                  const positionedpiechart(),
                ],
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            const Text(
              'Line chart for Sales Car',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
            ),
      const      SizedBox(height: 20,),
            SizedBox(
              height: 500,
              child: LineChartForSales(),
            ),
          ],
        ),
      ),
    );
  }
}

