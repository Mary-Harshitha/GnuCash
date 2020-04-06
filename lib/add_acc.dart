import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'parentAccount.dart';

class AddAccount extends StatefulWidget{
  String userAddress;

  AddAccount(this.userAddress);

  _AddStatePage createState() => _AddStatePage(userAddress);
}

class _AddStatePage extends State<AddAccount>{
  String userAddress;


  _AddStatePage(this.userAddress);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _accountNameController = TextEditingController();
  final _amountController = TextEditingController();
  final _accountDescController = TextEditingController();
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  String accName;
  String amount;
  FocusNode descFocus;
  FocusNode nameFocus;
  FocusNode amtFocus;
  String value;
  String holder;
  Item selectedItem;

  List<Item> items = <Item>[
    const Item('Assets'),
    const Item('Income'),
    const Item('Liabilities'),
    const Item('Expenses'),
  ];

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
    amtFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: Text('Create Account',style: TextStyle(
        fontWeight: FontWeight.bold,fontSize: 22
      ),),
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1,0.2, 0.5, 0.6, 0.9],
            colors: [
              Colors.pink, Colors.pink, Colors.pink, Colors.indigo, Colors.purple
            ]),
        actions: <Widget>[
        InkWell(
          child: RaisedButton(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),),elevation: 0,
              child: Text('SAVE',style: TextStyle(
            color: Colors.white,fontSize: 20
          ),),color: Colors.pink,
              onPressed: (){
            if(_formKey.currentState.validate()){
              Firestore.instance.collection(userAddress).add({
                'account_type' : holder,
                'money' : double.parse(_amountController.text),
                'fav': false,
                'account': _accountNameController.text,
              }
              );


              Navigator.pop(context);
            }
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
                      fontSize: 18
                    ),
                    cursorColor: Colors.orange,
                    focusNode: nameFocus,
                    controller: _accountNameController,
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
                      Text('Amount',style: TextStyle(
                        fontSize: 20,color: Colors.grey,
                      ),),
                      Expanded(
                      child:TextFormField(
                        style: TextStyle(
                            fontSize: 18
                        ),
                        cursorColor: Colors.orange,
                        focusNode: amtFocus,
                        controller: _amountController,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true
                        ),
                        decoration: InputDecoration(
                            labelText: '        Amount in Rs/...',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange)
                            ),
                            labelStyle: TextStyle(
                                fontSize: 16,color: amtFocus.hasFocus?
                            Colors.orange : Colors.grey
                            )
                        ),
                        validator: (input){ // ignore: missing_return
                          if(input.isEmpty){
                            return "Enter an amount";
                          }
                        },
                        onSaved: (input) => amount = input,
                      )
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 8),),
                  Text('ACCOUNT COLOR & TYPE',style: TextStyle(
                    fontSize: 15,color: Colors.grey,
                  ),),

                  Row(
                    children: <Widget>[
                    Text('Add color tile',style: TextStyle(
                      fontSize: 15,color: Colors.grey,
                    ),),
                      Expanded(
                      child:DropdownButtonHideUnderline(
                          child: DropdownButton<Item>(
                            value: selectedItem,
                            onChanged: (Item value) {
                              setState(() {

                              });
                            },
                            items: items.map((Item item) {
                              return DropdownMenuItem<Item>(
                                value: item,
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width: 10,),
                                    Text(
                                      item.accType,
                                      style:  TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                      )
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 4),),
                  TextFormField(
                    controller: _accountDescController,
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
                      Checkbox(value: _value2, onChanged: _value2Changed,
                        activeColor: Colors.orange,),
                      Expanded(
                      child:DropdownButtonFormField<Item>(
                        decoration: InputDecoration.collapsed(hintText: 'Select a type'),
                        validator: (input){ // ignore: missing_return
                          if(input == null){
                            return "Select a type";
                          }
                        },
                        value: selectedItem,
                        onChanged: (Item value) {
                          setState(() {
                            selectedItem = value;
                            holder =value.accType;
                          });
                        },
                        items: items.map((Item item) {
                          return DropdownMenuItem<Item>(
                            value: item,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10,),
                                Text(
                                  item.accType,
                                  style:  TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      
                      )
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
                        child:DropdownButton<Item>(
                          value: selectedItem,
                          onChanged: (Item value) {
                            setState(() {
                            });
                          },
                          items: items.map((Item item) {
                            return DropdownMenuItem<Item>(
                              value: item,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: 10,),
                                  Text(
                                    item.accType,
                                    style:  TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
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