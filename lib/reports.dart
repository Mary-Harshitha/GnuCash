import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Reports extends StatefulWidget{
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Reports>{
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(

      stream: Firestore.instance.collection('Accounts').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return LinearProgressIndicator();
        else if (snapshot.hasError)
          print('DATABASE ERROR: ${snapshot.error.toString()}');
        return _buildData(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildData(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 3.0),
      children: snapshot.map(
              (data) => _buildListItem(context, data)
      ).toList(),  //executes like a foreach statement
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
  }

  static var data = [
    ClicksPerYear('2017',27, Colors.grey),
    ClicksPerYear('2018',47, Colors.grey),
    ClicksPerYear('2019',30, Colors.grey),
  ];

  static var series = [
    charts.Series(
      id: 'clicks',
      domainFn: (ClicksPerYear clickData,_) => clickData.year,
      measureFn:(ClicksPerYear clickData,_) => clickData.clicks ,
      data: data,
      colorFn: (ClicksPerYear clickData,_) => clickData.color,
    ),
  ];

  static var chart = charts.BarChart(
    series,
    animate: true,
  );

  Widget chartWidget = Padding(
    padding: EdgeInsets.all(32.0),
    child: SizedBox(
      height: 180.0,
      child: chart,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: Text('Reports'),
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1,0.2, 0.5, 0.6, 0.9],
            colors: [
              Colors.pink,
              Colors.pink,
              Colors.indigo,
              Colors.indigo,
              Colors.purple
            ]),
        actions: <Widget>[
          InkWell(
              onTap: (){
              },
              child:Icon(Icons.filter_list,size: 32.0,)
          )

        ],
      ),
      body: Builder(
          builder: (BuildContext reportContext){
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ButtonBar(buttonMinWidth: 190.0,
                  alignment: MainAxisAlignment.start,
                  buttonHeight: 40,
                  children: <Widget>[
                    FlatButton(onPressed: (){},
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.pie_chart),
                          SizedBox(width: 10,),
                          Text('PIE CHART')
                        ],
                      ),
                      color: Colors.green,),
                    FlatButton(onPressed: (){},
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.equalizer),
                          SizedBox(width: 10,),
                          Text('BAR CHART')
                        ],
                      ),
                      color: Colors.deepOrange,),
                  ],
                ),
                ButtonBar(buttonMinWidth: 190.0,
                  alignment: MainAxisAlignment.start,
                  buttonHeight: 40,
                  children: <Widget>[
                    FlatButton(onPressed: (){},
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.trending_up),
                          SizedBox(width: 10,),
                          Text('LINE CHART')
                        ],
                      ),
                      color: Colors.blue,),
                    FlatButton(onPressed: (){},
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.subject),
                          SizedBox(width: 10,),
                          Text('SHEET')
                        ],
                      ),
                      color: Colors.pink,),
                  ],
                ),

                Container(
                    height: 300,
                    child:Padding(
                        padding: EdgeInsets.all(10),
                        child:Column(children: <Widget>[
                          Align(
                            alignment: Alignment.bottomLeft,
                            child:Text('Expenses for last 3 months',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,fontSize: 18,
                              ),),),
                          Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: chartWidget,
                          )
                        ],)
                    )
                ),

                Container(
                    height: 200,
                    child:Padding(
                      padding: EdgeInsets.all(10),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text('Total Assets'),
                              trailing: Text('0.00'),
                            ),
                            ListTile(
                              title: Text('Total Liabilities'),
                              trailing: Text('0.00'),
                            ),
                            ListTile(
                              title: Text('Net Worth'),
                              trailing: Text('0.00'),
                            ),
                          ],
                        ),
                      ),
                    )
                )

              ],
            );
          }
      ),

    );
  }
}

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color) :
        this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class Record {
  String account;
  String accountType;
  double money;
  bool favourite;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['account_type'] != null), //make sure data isn't null, assert is for that
        assert(map['account'] != null),
        assert(map['money'] != null),
        assert(map['fav'] != null),
        account = map['account'],
        accountType = map['account_type'],
        favourite = map['fav'],
        money = map['money'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}