



import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnimatedPieChart extends StatefulWidget {
  static String id = 'AnimatedPieChart';
  @override
  _AnimatedPieChartState createState() => _AnimatedPieChartState();
}

class _AnimatedPieChartState extends State<AnimatedPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PieChart(
          PieChartData(
            sections: _buildSections(),
            centerSpaceRadius: 40,
            borderData: FlBorderData(show: false),
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  setState(() {
                    touchedIndex = -1;
                  });
                  return;
                }
                setState(() {
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            // Duration of animation when the chart loads
            startDegreeOffset: 0,
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 16;
      final double radius = isTouched ? 100 : 90;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: Colors.white),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.green,
            value: 20,
            title: '20%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: Colors.white),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, color: Colors.white),
          );
        default:
          throw Error();
      }
    });
  }
}




class positionedpiechart extends StatelessWidget {
  const positionedpiechart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration:const BoxDecoration(color: Colors.blue),
            ),
        const    Text(' First',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
            
          ],
        ),
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration:const BoxDecoration(color: Colors.red),
            ),
        const    Text(' Second',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
            
          ],
        ),
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration:const BoxDecoration(color: Colors.green),
            ),
        const    Text(' Third',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
            
          ],
        ),
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration:const BoxDecoration(color: Colors.yellow),
            ),
        const    Text(' Fourth',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
            
          ],
        ),
      ],
    ));
  }
}
