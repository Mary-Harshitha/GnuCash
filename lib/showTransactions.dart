import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

// ignore: must_be_immutable
class AllTransactions extends StatefulWidget {
  String userAddress;
  String docId;
  AllTransactions(this.userAddress,this.docId);

  @override
  _TransactionPageState createState() => _TransactionPageState(userAddress,docId);
}

class _TransactionPageState extends State<AllTransactions> {
  String userAddress;
  String docId;
  _TransactionPageState(this.userAddress,this.docId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: GradientAppBar(
//        title: Text('Transactions'),
//        gradient: LinearGradient(
//            begin: Alignment.centerLeft,
//            end: Alignment.centerRight,
//            colors: [Colors.indigo,Colors.purple]),
//      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(

      stream: Firestore.instance.collection(userAddress).
      document(docId).collection(userAddress).snapshots(),
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
      key: ValueKey(record.amount),
      padding: EdgeInsets.symmetric(vertical: 0,horizontal: 1),
      child: ListTile(
                title: Text('${record.description}',style: TextStyle(
                    fontSize: 20
                ),),
                trailing: Container(
                  width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 8.0)),
                      Expanded(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('${record.amount.toStringAsFixed(2)}',textAlign: TextAlign.left,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Text('${record.date.toDate()}'),
                onTap: () {
                }
            ),

    );
  }
}

class Record {
  double amount;
  String description;
  Timestamp date;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['amount'] != null), //make sure data isn't null, assert is for that
        assert(map['description'] != null),
        assert(map['date'] != null),
        amount = map['amount'],
        description = map['description'],
        date = map['date'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}