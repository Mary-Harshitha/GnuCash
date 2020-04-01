import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'splashScreen.dart';
import 'dart:async';

class Reset extends StatefulWidget{
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset>{

  final _emailController = TextEditingController();
  String _email;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          title: Text('An email has been sent to your account email address.Please check your'
              'email to continue.',style: TextStyle(
              fontWeight: FontWeight.w300,fontSize: 16
          ),textAlign: TextAlign.center,),
          actions: <Widget>[
            FlatButton(onPressed: (){Navigator.pop(context);
            _emailController.clear();
            },
                child: Text('Ok',style: TextStyle(
                    fontSize: 18
                ),))
          ],
        );
        _emailController.clear();
      }catch(e)
      {
        showDialog(context: context,
            builder: (BuildContext context){
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                title: Text(e.message,style: TextStyle(
                    fontWeight: FontWeight.w300,fontSize: 18
                ),textAlign: TextAlign.center,),
                actions: <Widget>[
                  FlatButton(onPressed: (){Navigator.pop(context);
                  _emailController.clear();
                  },
                      child: Text('Ok',style: TextStyle(
                          fontSize: 18
                      ),))
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login help'),backgroundColor: Colors.black,),
      body: Builder(
        builder: (BuildContext splashContext){
          return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1,0.2, 0.5, 0.6, 0.9],
                      colors: [
                        Colors.black,
                        Colors.black,
                        Colors.grey,
                        Colors.black,
                        Colors.grey
                      ])
              ),
              child:Column(
                children: <Widget>[
                  SizedBox(height: 130),
                  Text('Enter your email address linked to you account',textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,decorationStyle: TextDecorationStyle.wavy,
                      fontFamily: 'segoe print',
                      color: Colors.white
                  ),),
                  SizedBox(height: 6),
                  Expanded(
                      child:Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child:Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                      filled: true,
                                      labelText: 'Email',
                                      labelStyle: TextStyle(
                                          color: Colors.white
                                      )
                                  ),
                                  validator: (input){ // ignore: missing_return
                                    if(input.isEmpty){
                                      return "Please enter an email address";
                                    }
                                  },
                                  onSaved: (input) => _email = input,
                                ),
                                //TODO TextField 2
                                SizedBox(height: 6.0),

                                //TODo ButtonBar
                                ConstrainedBox(
                                    constraints: const BoxConstraints(minWidth: double.infinity,minHeight: 50),
                                    child:RaisedButton(
                                        onPressed: signIn,
                                        padding: const EdgeInsets.all(0.0),
                                        textColor: Colors.white,
                                        child:ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              minWidth: double.infinity,minHeight: 50),
                                          child:Container(
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.black,Colors.grey,
                                                  Colors.black,Colors.black
                                                ],
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(10.0),
                                            child: const Text(
                                                'Next',textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
                                            ),
                                          ),)
                                    ))],
                            ),)
                      )
                  )
                ],
              )
          );
        },
      ),
    );
  }
}