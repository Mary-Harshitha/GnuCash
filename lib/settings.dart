import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Settings extends StatefulWidget{
  _SettingPageState createState() => _SettingPageState();
}

List<String> list = ['General','Manage Books','Accounts','Transactions',
'Backup & export','About','Recommend in Play store'];

class _SettingPageState extends State<Settings>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: Text('Settings'),gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.1,0.2, 0.5, 0.6, 0.9],
    colors: [
    Colors.pink,
    Colors.pink,
    Colors.indigo,
    Colors.indigo,
    Colors.purple
    ]),),
      body: Builder(
        builder: (BuildContext settingsContext){
          return ListView.builder(
            itemCount: list.length,
              itemBuilder: (BuildContext itemContext,int index){
                return Column(children: <Widget>[
                  ListTile(
                  title: Text(list[index].toString(),style: TextStyle(
                    fontSize: 18,color: Colors.black
                  ),),
                  ),
                  Divider(height: 1.0,)
                ],);

              }
          );
        },
      ),
    );
  }
}