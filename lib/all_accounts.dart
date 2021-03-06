import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'edit_acc.dart';
import 'newTransaction.dart';
import 'showTransactions.dart';

class Accounts extends StatelessWidget {
  final String userAddress;
  Accounts(this.userAddress);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AllAccounts(userAddress),
    );
  }
}

class AllAccounts extends StatefulWidget {
  final String userAddress;

  AllAccounts(this.userAddress);

  @override
  _AccountsPageState createState() => _AccountsPageState(userAddress);

}

class _AccountsPageState extends State<AllAccounts> {
  String userAddress;

  _AccountsPageState(this.userAddress);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(userAddress).snapshots(),
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
      key: ValueKey(record.account),
      padding: EdgeInsets.symmetric(vertical: 0,horizontal: 3),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.pinkAccent,width: 4.0
            )
          )
        ),
        height: 90,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: Colors.white,
        child: ListTile(
            title: Text(record.account,style: TextStyle(
              fontSize: 20
            ),),
            trailing: Container(
              width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Align(alignment: Alignment.topRight,
                    child: InkWell(
                      child: (!record.favourite)?
                      Icon(Icons.star_border):Icon(Icons.star,color: Colors.black,),
                      onTap: (){
                        Firestore.instance.collection(userAddress).document(record.reference.documentID).
                        updateData({"fav" : !record.favourite});
                      },
                    )
                    ),

                    Padding(padding: EdgeInsets.only(top: 8.0)),
                    Expanded(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Text('${(record.money.toDouble().toStringAsFixed(2))}',textAlign: TextAlign.left,),

                        InkWell(child: Icon(Icons.add),onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Transact(userAddress,
                                  data.documentID,record.money.toDouble(),record.account)
                                  ,fullscreenDialog: true));
                        },),

                        PopupMenuButton(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            itemBuilder: (context){
                              return [
                                PopupMenuItem(
                                    value: 1,
                                    child: Text('Delete')
                                ),
                                PopupMenuItem(
                                    value: 2,
                                    child: Text('Edit account')
                                ),
                              ];
                            },
                            onSelected: (value){
                              (value == 1)?showDialog(
                                  context: context,
                                   builder:  (BuildContext context){
                                return AlertDialog(shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                  title: Text('Are to sure that you want to delete'
                                      ' account "${record.account}"?',style: TextStyle(
                                    fontWeight: FontWeight.w400,fontSize: 18
                                  ),),
                                  actions: <Widget>[
                                    ButtonBar(
                                      children: <Widget>[
                                        FlatButton(
                                          child: Text('Cancel'),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                        ),
                                        RaisedButton(
                                            child: Text('Yes'),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              await Firestore.instance
                                                  .collection(userAddress)
                                                  .document(data.documentID)
                                                  .delete();
                                            },
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)),
                                        )
                                      ],
                                    )
                                  ],
                                );
                              }):
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => EditAccount(
                                          userAddress,data.documentID),fullscreenDialog: true));
                            },
                            ),
                      ],
                    ),
                    ),
                  ],
                ),
            ),

              subtitle: Text('${(record.accountType)}'),

            onTap: () {

              showDialog(
              context: context,
              builder:  (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  title: Text('Transactions'),
                  content: AllTransactions(userAddress, data.documentID),
                  );
              });

//              Navigator.push(context, MaterialPageRoute(builder: (context) =>
//                  ShowTransactions(userAddress,data.documentID),
//                  fullscreenDialog: true));
            }
        ),
      )
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