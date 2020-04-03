import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:flutter/animation.dart';
import 'package:simple_animations/simple_animations.dart';

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
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(top: 3.0),
      children: snapshot.map(
              (data) => _buildListItem(context, data)
      ).toList(),  //executes like a foreach statement
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
        key: ValueKey(record.account),
        padding: EdgeInsets.symmetric(vertical: 2,horizontal: 0),
        child: Container(
    height: 90,
    child: BarChartApplication(record.account.toString(), record.money),
    ));
  }

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
                            child:Text('All Transactions',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,fontSize: 18,
                              ),),),
                          SizedBox(height: 10),
                          Expanded(
                          child:Card(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: _buildBody(context),
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

class Bar extends StatelessWidget {
  final double height;
  final String label;
  final String amount;

  final int _baseDurationMs = 1000;
  final double _maxElementHeight = 100;

  Bar(this.height, this.label,this.amount);

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
      duration: Duration(milliseconds: (height * _baseDurationMs).round()),
      tween: Tween(begin: 0.0, end: height),
      builder: (context, animatedHeight) {
        return Column(
          children: <Widget>[
            SizedBox(height: 50),
            Container(
              height: (1 - animatedHeight) * _maxElementHeight,
            ),
            Text('$amount',style: TextStyle(
              fontSize: 12,color: Colors.yellow
            ),),
            Container(
              width: 30,
              height: animatedHeight * _maxElementHeight,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1,0.2, 0.5, 0.6, 0.9],
                      colors: [
                        Colors.purple,
                        Colors.purple,
                        Colors.indigo,
                        Colors.indigo,
                        Colors.pink
                      ])
              ),
            ),
            SizedBox(height: 5,),
            Text(label,style: TextStyle(
                fontSize: 16,color: Colors.white
            ),)
          ],
        );
      },
    );
  }
}

class BarChartApplication extends StatelessWidget {
  final String account;
  final double money;
  final double hh = 100.0;
  final double tt = 1000.0;
  BarChartApplication(this.account, this.money);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Bar((money)>100?(money)/tt:(money)/hh, account,money.toString()),
        ],
      ),
    );
  }
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