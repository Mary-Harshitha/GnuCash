import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
//import 'package:flutter/animation.dart';
//import 'package:simple_animations/simple_animations.dart';
import 'pieChart.dart';
import 'barChart.dart';
import 'line.dart';


class Reports extends StatefulWidget{
  final String userAddress;

  Reports(this.userAddress);

  _ReportState createState() => _ReportState(userAddress);
}

class _ReportState extends State<Reports>{
  String userAddress;

  _ReportState(this.userAddress);

//  Widget _buildBody(BuildContext context) {
//    return StreamBuilder<QuerySnapshot>(
//
//      stream: Firestore.instance.collection(userAddress).snapshots(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData)
//          return LinearProgressIndicator();
//        else if (snapshot.hasError)
//          print('DATABASE ERROR: ${snapshot.error.toString()}');
//        return _buildList(context, snapshot.data.documents);
//      },
//    );
//  }
//
//  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//    return ListView(
//      scrollDirection: Axis.horizontal,
//      padding: const EdgeInsets.only(top: 3.0),
//      children: snapshot.map(
//              (data) => _buildListItem(context, data)
//      ).toList(),  //executes like a foreach statement
//    );
//  }
//
//  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//    final record = Record.fromSnapshot(data);
//
//    return Padding(
//        key: ValueKey(record.account),
//        padding: EdgeInsets.symmetric(vertical: 2,horizontal: 0),
//        child: Container(
//    height: 90,
//    child: BarChartApplication(record.account.toString(), record.money),
//    ));
//  }

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
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ButtonBar(buttonMinWidth: 190.0,
                  alignment: MainAxisAlignment.start,
                  buttonHeight: 50,
                  children: <Widget>[
                    FlatButton(onPressed: (){

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              PieChart(userAddress),fullscreenDialog: true));
                    },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.pie_chart),
                          SizedBox(width: 10,),
                          Text('PIE CHART')
                        ],
                      ),
                      color: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                        )),

                    FlatButton(onPressed: (){

                    Navigator.push(context,MaterialPageRoute(builder: (context) =>
                          BarChart(userAddress),fullscreenDialog: true));
                    },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.equalizer),
                          SizedBox(width: 10,),
                          Text('BAR CHART')
                        ],
                      ),
                      color: Colors.pink,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                        )),
                  ],
                ),
//                ButtonBar(buttonMinWidth: 190.0,
//                  alignment: MainAxisAlignment.start,
//                  buttonHeight: 40,
//                  children: <Widget>[
//                    FlatButton(onPressed: (){
//                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
//                          LineChart(userAddress),fullscreenDialog: true));
//                    },
//                      child: Row(
//                        children: <Widget>[
//                          Icon(Icons.trending_up),
//                          SizedBox(width: 10,),
//                          Text('LINE CHART')
//                        ],
//                      ),
//                      color: Colors.blue,
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(20)
//                    ),),
//                    FlatButton(onPressed: (){
//
//                    },
//                      child: Row(
//                        children: <Widget>[
//                          Icon(Icons.subject),
//                          SizedBox(width: 10,),
//                          Text('SHEET')
//                        ],
//                      ),
//                      color: Colors.pink,
//                        shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(20)
//                        )),
//                  ],
//                ),
              SizedBox(height: 30,),

                Container(
                    height: 300,
                    child:Padding(
                        padding: EdgeInsets.all(0),
                        child:Column(children: <Widget>[
                          Align(
                            alignment: Alignment.bottomLeft),
                          SizedBox(height: 10),
                          Expanded(
                          child:Card(
//                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: LineChartSample1(),
                          ))
                        ],)
                    )
                ),
              ],
            ));
          }
      ),

    );
  }
}

//class Bar extends StatelessWidget {
//  final double height;
//  final String label;
//  final String amount;
//
//  final int _baseDurationMs = 1000;
//  final double _maxElementHeight = 100;
//
//  Bar(this.height, this.label,this.amount);
//
//  @override
//  Widget build(BuildContext context) {
//    return ControlledAnimation(
//      duration: Duration(milliseconds: (height * _baseDurationMs).round()),
//      tween: Tween(begin: 0.0, end: height),
//      builder: (context, animatedHeight) {
//        return Column(
//          children: <Widget>[
//            SizedBox(height: 50),
//            Container(
//              height: (1 - animatedHeight) * _maxElementHeight,
//            ),
//            Text('$amount',style: TextStyle(
//              fontSize: 12,color: Colors.indigo
//            ),),
//            Container(
//              width: 20,
//              height: animatedHeight * _maxElementHeight,
//              decoration: BoxDecoration(
//                  gradient: LinearGradient(
//                      begin: Alignment.topRight,
//                      end: Alignment.bottomLeft,
//                      stops: [0.1,0.2, 0.5, 0.6, 0.9],
//                      colors: [
//                        Colors.blue,
//                        Colors.blue,
//                        Colors.blue,
//                        Colors.blue,
//                        Colors.blue
//                      ])
//              ),
//            ),
//            SizedBox(height: 5,),
//            Text(label,style: TextStyle(
//                fontSize: 16,color: Colors.black
//            ),)
//          ],
//        );
//      },
//    );
//  }
//}
//
//class BarChartApplication extends StatelessWidget {
//  final String account;
//  final double money;
//  final double hh = 100.0;
//  final double tt = 1000.0;
//  BarChartApplication(this.account, this.money);
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.all(20.0),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        children: <Widget>[
//          Bar((money)>100?(money)/tt:(money)/hh, account,money.toString()),
//        ],
//      ),
//    );
//  }
//}
//
//class Record {
//  String account;
//  String accountType;
//  double money;
//  bool favourite;
//  final DocumentReference reference;
//
//  Record.fromMap(Map<String, dynamic> map, {this.reference})
//      : assert(map['account_type'] != null), //make sure data isn't null, assert is for that
//        assert(map['account'] != null),
//        assert(map['money'] != null),
//        assert(map['fav'] != null),
//        account = map['account'],
//        accountType = map['account_type'],
//        favourite = map['fav'],
//        money = map['money'];
//
//  Record.fromSnapshot(DocumentSnapshot snapshot)
//      : this.fromMap(snapshot.data, reference: snapshot.reference);
//}