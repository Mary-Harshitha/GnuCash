import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class Transact extends StatefulWidget{
  String userAddress;
  String docId;
  String account;
  double amt;
  Transact(this.userAddress,this.docId,this.amt,this.account);

  _TransactState createState() => _TransactState(userAddress,docId,amt,account);
}

class _TransactState extends State<Transact>{
  String userAddress;
  String id;
  String account;
  double amt;
  _TransactState(this.userAddress,this.id,this.amt,this.account);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _descController = TextEditingController();
  final _amtController = TextEditingController();
  bool isSwitched = false;
  String status = 'Receive';
  DateTime dt = DateTime.now();
  double nValue;
  double transact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text('New Transaction'),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.indigo,Colors.purple]),
        actions: <Widget>[
            RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),),elevation: 0,
                child: Text('SAVE',style: TextStyle(
                    color: Colors.white,fontSize: 20
                ),),color: Colors.purple,
                onPressed: (){
                  if(_formKey.currentState.validate())
                  {
                    (status != 'Spend')?transact = double.parse(_amtController.text):
                    transact= -(double.parse(_amtController.text));
                    nValue = amt + (transact);
                    Firestore.instance.collection(userAddress).document(id).
                    updateData({"money" : nValue});

                    Firestore.instance.collection(userAddress).document(id).collection(userAddress).document().setData(
                      {
                        'description' : _descController.text,
                        'amount' : transact,
                        'date': dt,
                      }
                    );
//                    add({

//                    }
//                    );
                    Navigator.pop(context);
                  }
                }
                ),
        ],
      ),
      body: Builder(
        builder: (BuildContext transContext){
          return Container(
            padding: EdgeInsets.all(20.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _descController,
                    decoration: InputDecoration(
                      labelText: 'Description',labelStyle: TextStyle(
                        fontSize: 20
                    )
                    ),
                    validator: (input){ // ignore: missing_return
                      if(input.isEmpty){
                        return "Give a description";
                      }
                    },
                    onSaved: (input) {

                    },
                  ),
                      SizedBox(height: 10.0,),

                      Text('\u20B9',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 25,color: Colors.green
                      ),),

                          TextFormField(
                            keyboardType: TextInputType.numberWithOptions(),
                            controller: _amtController,
                            decoration: InputDecoration(
                                labelText: 'Amount',labelStyle: TextStyle(
                                fontSize: 20
                            )
                            ),
                            validator: (input){ // ignore: missing_return
                              if(input.isEmpty){
                                return "Enter an amount";
                              }
                            },
                            onSaved: (input) {},
                          ),
                  Row(
                    children: <Widget>[
                      Text(status,style: TextStyle(
                        fontSize: 18
                      ),),
                      Switch(
                        value: isSwitched,
                        onChanged: (value){
                          setState((){
                            isSwitched = value;
                            if(value == true){status = 'Spend';}
                            else{status = 'Receive';}
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}