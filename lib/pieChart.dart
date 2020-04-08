import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'chartData.dart';
import 'dart:math';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class PieChart extends StatefulWidget {
  final String userAddress;

  PieChart(this.userAddress);

  @override
  _PieChartState createState() {
    return _PieChartState(userAddress);
  }
}

class _PieChartState extends State<PieChart> {
  String user;

  _PieChartState(this.user);

  List<charts.Series<FireData, String>> _seriesPieData;
  List<FireData> mydata;
  _generateData(mydata) {
    _seriesPieData = List<charts.Series<FireData, String>>();
    _seriesPieData.add(
      charts.Series(
        domainFn: (FireData task, _) => task.account,
        measureFn: (FireData task, _) => task.amount,
        colorFn: (FireData task, _) =>
            charts.ColorUtil.fromDartColor(myColor),
        id: 'tasks',
        data: mydata,
        labelAccessorFn: (FireData row, _) => "${row.account}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: Text('Pie chart',style: TextStyle(
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
          List<FireData> task = snapshot.data.documents
              .map((documentSnapshot) => FireData.fromMap(documentSnapshot.data))
              .toList();
          return _buildChart(context, task);
        }
      },
    );
  }

  final Color myColor = UniqueColorGenerator.getColor();

  Widget _buildChart(BuildContext context, List<FireData> pieData) {
    mydata = pieData;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[

              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.PieChart(_seriesPieData,
                    animate: true,
                    animationDuration: Duration(seconds: 3),
//                    behaviors: [
//                      new charts.DatumLegend(
//                        outsideJustification:
//                        charts.OutsideJustification.endDrawArea,
//                        horizontalFirst: false,
//                        desiredMaxRows: 2,
//                        cellPadding:
//                        new EdgeInsets.only(right: 4.0, bottom: 4.0,top:4.0),
//                        entryTextStyle: charts.TextStyleSpec(
//                            color: charts.MaterialPalette.purple.shadeDefault,
//                            fontFamily: 'Georgia',
//                            fontSize: 12),
//                      )
//                    ],
                    defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 100,
                        arcRendererDecorators: [
                          new charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside)
                        ])
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