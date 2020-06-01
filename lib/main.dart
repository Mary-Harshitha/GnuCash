import 'package:flutter/material.dart';
import 'package:gnu_cash/appIntro.dart';
import 'home.dart';
import 'package:gnu_cash/run_main.dart';
import 'splashScreen.dart';

void main() => runApp(RunApp());

class MyApp extends StatefulWidget{
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {

  // Future checkFirstSeen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool _seen = (prefs.getBool('seen') ?? false);

  //   if (_seen) {
  //     Navigator.of(context).pushReplacement(
  //          MaterialPageRoute(builder: (context) => Splash()));
  //   } else {
  //     await prefs.setBool('seen', true);
  //     Navigator.of(context).pushReplacement(
  //          MaterialPageRoute(builder: (context) => Intro()));
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   Timer(Duration(milliseconds: 200), () {
  //     checkFirstSeen();
  //   });
  // }

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

