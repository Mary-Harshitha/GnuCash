import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

// ignore: must_be_immutable
class ShowTransactions extends StatelessWidget {
  String account;

  ShowTransactions(this.account);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AllTransactions(account),
    );
  }
}

// ignore: must_be_immutable
class AllTransactions extends StatefulWidget {
  String account;
  AllTransactions(this.account);

  @override
  _TransactionPageState createState() => _TransactionPageState(account);
}

class _TransactionPageState extends State<AllTransactions> {
  String account;
  _TransactionPageState(this.account);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text('Transactions'),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.indigo,Colors.purple]),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(

      stream: Firestore.instance.collection('Transactions').snapshots(),
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
      padding: const EdgeInsets.only(top: 3.0),
      children: snapshot.map(
              (data) => _buildListItem(context, data)
      ).toList(),  //executes like a foreach statement
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.accName),
      padding: EdgeInsets.symmetric(vertical: 0,horizontal: 3),
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(
                      color: Colors.indigoAccent,width: 4.0
                  )
              )
          ),
          height: 90,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            color: Colors.white,
            child: ListTile(

                title: Text('${(record.accName == account)?record.description:''}',style: TextStyle(
                    fontSize: 20
                ),),
                trailing: Container(
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 8.0)),
                      Expanded(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('${(record.accName == account)?record.amount.toStringAsFixed(2):''}',textAlign: TextAlign.left,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Text('${(record.accName == account)?record.date.toDate():''}'),
                onTap: () {
                }
            ),
          )
      ),
    );
  }
}

class Record {
  String accName;
  double amount;
  String description;
  Timestamp date;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['amount'] != null), //make sure data isn't null, assert is for that
        assert(map['description'] != null),
        assert(map['account'] != null),
        assert(map['date'] != null),
        amount = map['amount'],
        accName = map['account'],
        description = map['description'],
        date = map['date'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}