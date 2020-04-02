import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:flutter/animation.dart';
import 'package:simple_animations/simple_animations.dart';

class Reports extends StatefulWidget{
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Reports>{

  String account;
  double amount;

  @override
  void initState(){
    super.initState();
    queryValues();
  }

  void queryValues(){
    Firestore.instance
        .collection('Accounts')
        .snapshots()
        .listen((snapshot) {
          DocumentSnapshot documentSnapshot;
          String account1 = Record.fromSnapshot(documentSnapshot).account.toString();
      //double tempTotal = snapshot.documents.fold(0, (tot, doc) => tot + doc.data['amount']);
          double amount1 = Record.fromSnapshot(documentSnapshot).money;
      setState(() {
        account = account1;
        amount = amount1;
      });
      debugPrint(account.toString());
    });
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
                            child: BarChartApplication(account,amount),
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

class Bar extends StatelessWidget {
  final double height;
  final String label;

  final int _baseDurationMs = 1000;
  final double _maxElementHeight = 100;

  Bar(this.height, this.label);

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
      duration: Duration(milliseconds: (height * _baseDurationMs).round()),
      tween: Tween(begin: 0.0, end: height),
      builder: (context, animatedHeight) {
        return Column(
          children: <Widget>[
            SizedBox(height: 50,),
            Container(
              height: (1 - animatedHeight) * _maxElementHeight,
            ),
            Container(
              width: 20,
              height: animatedHeight * _maxElementHeight,
              color: Colors.blue,
            ),
            Text(label,style: TextStyle(
                fontSize: 12,color: Colors.purple
            ),)
          ],
        );
      },
    );
  }
}

class BarChartApplication extends StatelessWidget {
  String account;
  double money;
  BarChartApplication(this.account, this.money);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Bar(0.3, "2013"),
RaisedButton(onPressed:(){
  print(account);
  print('$money');
},child: Text('Press'),)
//          Bar(0.5, "2014"),
//          Bar(0.7, "2015"),
//          Bar(0.8, "2016"),
//          Bar(0.9, "2017"),
//          Bar(0.98, "2018"),
//          Bar(0.84, "2019"),
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