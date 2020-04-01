import 'package:flutter/material.dart';
import 'appIntro.dart';
import 'home.dart';
import 'splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
           MaterialPageRoute(builder: (context) => Splash()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
           MaterialPageRoute(builder: (context) => Intro()));
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 200), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'home' : (context) => Home(),
        'login' : (context) => Splash(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}

