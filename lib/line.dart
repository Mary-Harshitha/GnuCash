import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
//import 'package:gradient_app_bar/gradient_app_bar.dart';

class LineChartSample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: GradientAppBar(title: Text('Line chart',style: TextStyle(
//          fontWeight: FontWeight.bold,fontSize: 22
//      ),),
//        gradient: LinearGradient(
//            begin: Alignment.topRight,
//            end: Alignment.bottomLeft,
//            stops: [0.1,0.2, 0.5, 0.6, 0.9],
//            colors: [
//              Colors.pink, Colors.pink, Colors.pink, Colors.indigo, Colors.purple
//            ]),
//      ),
      body: Center(
      child:AspectRatio(
      aspectRatio: 1.23,
      child: Container(
//        decoration: BoxDecoration(
//          borderRadius: const BorderRadius.all(Radius.circular(18)),
//          gradient: LinearGradient(
//            colors: const [
//              Colors.white,
//              Colors.white,
//            ],
//            begin: Alignment.bottomCenter,
//            end: Alignment.topCenter,
//          ),
//        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0.0, left: 0.0),
                    child: LineChart(
                      //isShowingMainData ? sampleData1() :
                      sampleData2(),
                      swapAnimationDuration: Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
              ],
            ),
//            IconButton(
//              icon: Icon(
//                Icons.refresh,
//                color: Colors.green.withOpacity(isShowingMainData ? 1.0 : 0.5),
//              ),
//              onPressed: () {
//                setState(() {
//                  isShowingMainData = !isShowingMainData;
//                });
//              },
//            )
          ],
        ),
      ),
    )));
  }

//  LineChartData sampleData1() {
//    return LineChartData(
//      lineTouchData: LineTouchData(
//        touchTooltipData: LineTouchTooltipData(
//          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
//        ),
//        touchCallback: (LineTouchResponse touchResponse) {
//          print(touchResponse);
//        },
//        handleBuiltInTouches: true,
//      ),
//      gridData: const FlGridData(
//        show: false,
//      ),
//      titlesData: FlTitlesData(
//        bottomTitles: SideTitles(
//          showTitles: true,
//          reservedSize: 22,
//          textStyle: TextStyle(
//            color: const Color(0xff72719b),
//            fontWeight: FontWeight.bold,
//            fontSize: 16,
//          ),
//          margin: 10,
//          getTitles: (value) {
//            switch (value.toInt()) {
//              case 2:
//                return 'SEPT';
//              case 7:
//                return 'OCT';
//              case 12:
//                return 'DEC';
//            }
//            return '';
//          },
//        ),
//        leftTitles: SideTitles(
//          showTitles: true,
//          textStyle: TextStyle(
//            color: const Color(0xff75729e),
//            fontWeight: FontWeight.bold,
//            fontSize: 14,
//          ),
//          getTitles: (value) {
//            switch (value.toInt()) {
//              case 1:
//                return '1m';
//              case 2:
//                return '2m';
//              case 3:
//                return '3m';
//              case 4:
//                return '5m';
//            }
//            return '';
//          },
//          margin: 8,
//          reservedSize: 30,
//        ),
//      ),
//      borderData: FlBorderData(
//        show: true,
//        border: Border(
//          bottom: BorderSide(
//            color: const Color(0xff4e4965),
//            width: 4,
//          ),
//          left: BorderSide(
//            color: Colors.transparent,
//          ),
//          right: BorderSide(
//            color: Colors.transparent,
//          ),
//          top: BorderSide(
//            color: Colors.transparent,
//          ),
//        ),
//      ),
//      minX: 0,
//      maxX: 14,
//      maxY: 4,
//      minY: 0,
//      lineBarsData: linesBarData1(),
//    );
//  }

  List<LineChartBarData> linesBarData1() {
    LineChartBarData lineChartBarData1 = const LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      colors: [
        Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
      isCurved: true,
      colors: [
        Color(0xffaa4cfc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        Color(0x00aa4cfc),
      ]),
    );
    LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: const [
        FlSpot(1, 2.8),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(13, 2.5),
      ],
      isCurved: true,
      colors: const [
        Color(0xff27b6fc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(
        show: false,
      ),
      belowBarData: const BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
      lineChartBarData3,
    ];
  }

  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: const LineTouchData(
        enabled: false,
      ),
      gridData: const FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: TextStyle(
            color: const Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'Acc1';
              case 7:
                return 'Acc2';
              case 12:
                return 'Acc3';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: const Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'May';
              case 2:
                return 'Apr';
              case 3:
                return 'Mar';
              case 4:
                return 'Feb';
              case 5:
                return 'Jan';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: const Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: 14,
      maxY: 6,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    return [
      const LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: [
          Color(0x444af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
      const LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
        isCurved: true,
        colors: [
          Color(0x99aa4cfc),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          Color(0x33aa4cfc),
        ]),
      ),
      const LineChartBarData(
        spots: [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: [
          Color(0x4427b6fc),
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];
  }
}