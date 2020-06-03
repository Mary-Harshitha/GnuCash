import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'splashScreen.dart';
import 'dart:async';

class User extends StatefulWidget{
  _UserState createState() => _UserState();
}

class _UserState extends State<User>{

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _email, _password, _username;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email, password: _password);

        Firestore.instance.collection('Users').add(
            {
              'username': _username,
              'email': _email,
              'password': _password,
            }
        );
        _emailController.clear();
        _passwordController.clear();

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
                  _emailController.clear();_passwordController.clear();},
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
      appBar: AppBar(title: Text('Registration'),backgroundColor: Colors.indigo,),
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
                        Colors.indigo,
                        Colors.indigo,
                        Colors.cyan,
                        Colors.indigo,
                        Colors.cyan
                      ])
              ),
              child:Column(
                children: <Widget>[
                  SizedBox(height: 170),
                  Expanded(
                      child:Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child:Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: _nameController,
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                      filled: true,
                                      labelText: 'Username',
                                      labelStyle: TextStyle(
                                          color: Colors.white
                                      )
                                  ),
                                  validator: (input){ // ignore: missing_return
                                    if(input.isEmpty){
                                      return "Please enter your name";
                                    }
                                  },
                                  onSaved: (input) => _username = input,
                                ),
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
                                TextFormField(
                                  controller: _passwordController,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                      filled: true,
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                          color: Colors.white
                                      )
                                  ),
                                  // ignore: missing_return
                                  validator: (input){
                                    if(input.length < 6){
                                      return "Your password must be atleast 6 characters";
                                    }
                                  },
                                  onSaved: (input) => _password = input,
                                  obscureText: true,
                                ),
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
                                                  Colors.indigo,Colors.cyan,
                                                  Colors.indigo,Colors.indigo
                                                ],
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(10.0),
                                            child: const Text(
                                                'Register',textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
                                            ),
                                          ),)
                                    )),
                              ],
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