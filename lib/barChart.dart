import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'chartData.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class BarChart extends StatefulWidget {
  final String userAddress;

  BarChart(this.userAddress);
  @override
  _BarChartState createState() {
    return _BarChartState(userAddress);
  }
}

class _BarChartState extends State<BarChart> {
  String user;

  _BarChartState(this.user);

  List<charts.Series<FireData, String>> _seriesBarData;
  List<FireData> mydata;
  _generateData(myData)
  {
    _seriesBarData = List<charts.Series<FireData, String>>();
    _seriesBarData.add(
      charts.Series(
        domainFn: (FireData acc, _) => acc.account.substring(0,4),
        measureFn: (FireData amt, _) => amt.amount,
        colorFn: (FireData color, _) =>
            charts.ColorUtil.fromDartColor(myColor),
        id: 'PieData',
        data: myData,
        labelAccessorFn: (FireData row, _) => "${row.account}",
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: Text('All Transactions',style: TextStyle(
          fontWeight: FontWeight.bold,fontSize: 22
      ),),
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1,0.2, 0.5, 0.6, 0.9],
            colors: [
              Colors.pink, Colors.pink, Colors.pink, Colors.indigo, Colors.purple
            ]),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(user).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<FireData> data = snapshot.data.documents
              .map((documentSnapshot) => FireData.fromMap(documentSnapshot.data))
              .toList();
          return _buildChart(context, data);
        }
      },
    );
  }

  final Color myColor = UniqueColorGenerator.getColor();

  Widget _buildChart(BuildContext context, List<FireData> barData) {
    mydata = barData;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
//              Text(
//                'All accounts',
//                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.BarChart(_seriesBarData,
                  animate: true,
                  animationDuration: Duration(seconds:5),
//                  behaviors: [
//                    new charts.DatumLegend(
//                      entryTextStyle: charts.TextStyleSpec(
//                          color: charts.MaterialPalette.purple.shadeDefault,
//                          fontFamily: 'Georgia',
//                          fontSize: 5),
//                    )
//                  ],
//                    defaultRenderer: new charts.BarRendererConfig(
//                        strokeWidthPx: 100,
//
//                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UniqueColorGenerator {
  static Random random = new Random();
  static Color getColor() {
    return Color.fromARGB(255, random.nextInt(255),
        random.nextInt(255), random.nextInt(255));
  }
}