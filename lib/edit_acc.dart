import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

// ignore: must_be_immutable
class EditAccount extends StatefulWidget{
  String accountName;
  String docId;
  EditAccount(this.accountName,this.docId);
  _EditStatePage createState() => _EditStatePage(accountName,docId);
}

class _EditStatePage extends State<EditAccount>{
  final String name,id;
  _EditStatePage(this.name,this.id);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _accountnameController = TextEditingController();
  final _accountdescController = TextEditingController();
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  String accName;
  FocusNode descFocus;
  FocusNode nameFocus;
  String value;

  void _value1Changed(bool value){
    setState(() => _value1 = value);
  }
  void _value2Changed(bool value){
    setState(() => _value2 = value);
  }
  void _value3Changed(bool value){
    setState(() => _value3 = value);
  }

  @override
  void initState(){
    descFocus = FocusNode();
    nameFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: Text('Edit Account',style: TextStyle(
          fontWeight: FontWeight.bold,fontSize: 22
      ),),
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1,0.2, 0.5, 0.6, 0.9],
            colors: [
              Colors.orange,
              Colors.orange,
              Colors.orange,
              Colors.redAccent,
              Colors.purple
            ]),
        actions: <Widget>[
          InkWell(
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),),elevation: 0,
                child: Text('SAVE',style: TextStyle(
                color: Colors.white,fontSize: 20
            ),),color: Colors.orange,
                onPressed: (){
                  Firestore.instance.collection(name).document(id).
                  updateData({"account" : _accountnameController.text});
                  Navigator.pop(context);
                }),
          )
        ],),

      body: Builder(
        builder: (BuildContext accContext){
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 1),
            child:SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(
                          fontSize: 24
                      ),
                      cursorColor: Colors.orange,
                      focusNode: nameFocus,
                      controller: _accountnameController,
                      decoration: InputDecoration(
                          labelText: 'Account name',
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange)
                          ),
                          labelStyle: TextStyle(
                              fontSize: 20,color: nameFocus.hasFocus? Colors.orange : Colors.grey
                          )
                      ),
                      validator: (input){ // ignore: missing_return
                        if(input.isEmpty){
                          return "Enter an account name to create an account";
                        }
                      },
                      onSaved: (input) => accName = input,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8),),
                    Row(
                      children: <Widget>[
                        Text('CURRENCY',style: TextStyle(
                          fontSize: 15,color: Colors.grey,
                        ),),
                        Expanded(
                            child:DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,

                                  items: <String>['ADF - Andorran Franc', 'ADP - Andorran Peseta', 'AED - UAE Dirham', 'AFA - Afghani'].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String _value) {
                                    setState((){
                                    });
                                  },
                                ))
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8),),
                    Text('ACCOUNT COLOR & TYPE',style: TextStyle(
                      fontSize: 15,color: Colors.grey,
                    ),),

                    Row(
                      children: <Widget>[
                        //                  CircleColorPicker(
//                    initialColor: Colors.blue,
//                    onChanged: (color) => print(color),
//                    size: const Size(240, 240),
//                    strokeWidth: 4,
//                    thumbSize: 36,
//                  ),
                        Text('Add color tile',style: TextStyle(
                          fontSize: 15,color: Colors.grey,
                        ),),
                        Expanded(
                            child:DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  items: <String>['CASH', 'BANK', 'CREDIT CARD', 'ASSET'].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (_) {},
                                )
                            )
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 4),),
                    TextFormField(
                      controller: _accountdescController,
                      cursorColor: Colors.orange,
                      focusNode: descFocus,
                      decoration: InputDecoration(
                          labelText: 'Account description',
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange)
                          ),
                          labelStyle: TextStyle(
                            fontSize: 20,color: descFocus.hasFocus? Colors.orange : Colors.grey,
                          )
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 4),),
                    Row(
                        children:<Widget>[
                          Checkbox(value: _value1, onChanged: _value1Changed,activeColor: Colors.orange,),
                          Text('Placeholder account')
                        ]
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 2),),
                    Text('PARENT ACCOUNT',style: TextStyle(
                        fontSize: 14,color: Colors.grey
                    ),),
                    Row(
                        children: <Widget>[
                          Checkbox(value: _value2, onChanged: _value2Changed,activeColor: Colors.orange,),
                          Expanded(
                              child:DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    items: <String>['ASSETS', 'LIABILITIES', 'EQUITY', 'INCOME'].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      value = value;
                                    },
                                  )))
                        ]
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 2),),
                    Text('DEFAULT TRANSFER ACCOUNT',style: TextStyle(
                        fontSize: 14,color: Colors.grey
                    ),),
                    Row(
                        children: <Widget>[
                          Checkbox(value: _value3, onChanged: _value3Changed,activeColor: Colors.orange,),
                          Expanded(
                            child:DropdownButtonHideUnderline(
                                child:DropdownButton<String>(
                                  isExpanded: true,
                                  items: <String>['CASH', 'BANK', 'CREDIT CARD', 'ASSET'].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (_) {},
                                )
                            ),
                          ),
                        ]
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}