import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartForSales extends StatefulWidget {
  @override
  _LineChartForSales createState() => _LineChartForSales();
}

class _LineChartForSales extends State<LineChartForSales>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LineChart(
          LineChartData(
             gridData:const FlGridData(
              drawHorizontalLine: true,
              drawVerticalLine: false // تعطيل الخطوط في الخلفية
            ),
            backgroundColor: const Color(0xff322A53),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    String text;
                    switch (value.toInt()) {
                      case 1:
                        text = '1M';
                        break;
                      case 2:
                        text = '2M';
                        break;
                      case 3:
                        text = '3M';
                        break;
                      case 4:
                        text = '4M';
                        break;
                      case 5:
                        text = '5M';
                        break;
                      case 6:
                        text = '6M';
                        break;
                      case 7:
                        text = '7M';
                        break;
                      case 8:
                        text = '8M';
                        break;
                      case 9:
                        text = '9M';
                        break;
                      case 10:
                        text = '10M';
                        break;
                      default:
                        text = '';
                    }
                    return Text(
                      text,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ), // تخصيص خصائص النص
                    );
                  }, // المسافة بين النص والمحور
                  interval:
                      1, // لضبط المسافة بين النصوص// المسافة بين النص والمحور
              reservedSize: 30
                ),
              ),
              rightTitles: const AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: false)), // تعطيل النصوص على المحور العمودي
              topTitles: const AxisTitles(
                  sideTitles: SideTitles(
                      showTitles:
                          false)), // تعطيل النصوص على المحور العمودي // تعطيل النصوص على المحور العمودي
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true, // تفعيل النصوص على المحور الأفقي
                  getTitlesWidget: (value, meta) {
                    // هنا يمكنك تخصيص النصوص بناءً على قيمة النقاط على المحور X
                    String text;
                    switch (value.toInt()) {
                      case 1:
                        text = 'Jan';
                        break;
                      case 2:
                        text = 'Feb';
                        break;
                      case 3:
                        text = 'Mar';
                        break;
                      case 4:
                        text = 'Apr';
                        break;
                      case 5:
                        text = 'May';
                        break;
                      case 6:
                        text = 'Jun';
                        break;
                      case 7:
                        text = 'Jul';
                        break;
                      case 8:
                        text = 'Aug';
                        break;
                      case 9:
                        text = 'Sep';
                        break;
                      case 10:
                        text = 'Oct';
                        break;
                      case 11:
                        text = 'Nov';
                        break;
                      case 12:
                        text = 'Dec';
                        break;
                      default:
                        text = '';
                    }
                    return Text(
                      text,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ), // تخصيص خصائص النص
                    );
                  }, // المسافة بين النص والمحور
                  interval:
                      1, // لضبط المسافة بين النصوص// المسافة بين النص والمحور
                ),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(0, 0),
                  FlSpot(1, 1),
                  FlSpot(2, 2.2),
                  FlSpot(3, 4),
                  FlSpot(4, 8),
                  FlSpot(5, 5),
                  FlSpot(6, 6),
                  FlSpot(7, 2),
                  FlSpot(8, 3),
                  FlSpot(9, 1),
                  FlSpot(10, 5),
                  FlSpot(11, 8),
                  FlSpot(12, 4),
                ],
                isCurved: true,
                color: Colors.blue,
                barWidth: 10,
                dotData: FlDotData(
                  show: true, // لعرض النقاط
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 8, // تحديد حجم النقاط
                      color: Colors.black, // تحديد اللون
                      strokeWidth: 1.5, // سمك الحدود
                      strokeColor: Colors.purpleAccent, // لون الحدود
                    );
                  },
                ),
              ),
            ],
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (touchedSpot) {
                  return Colors.black;
                },
                getTooltipItems: (touchedSpots) {
                  if (touchedSpots.isNotEmpty) {
                    // Start the animation when a spot is touched
                    _animationController?.forward();
                    return touchedSpots.map((spot) {
                      return LineTooltipItem(
                        '${spot.y}',
                         TextStyle(
                            color: Colors.purpleAccent[200],
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      );
                    }).toList();
                  } else {
                    // Reset animation when no spot is touched
                    _animationController?.reverse();
                    return [];
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
