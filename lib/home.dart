import 'dart:async';
import 'package:flutter/material.dart';
import 'all_accounts.dart';
import 'add_acc.dart';
import 'favourites.dart';
import 'reports.dart';
import 'settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'splashScreen.dart';

class Home extends StatefulWidget {
  final FirebaseUser user;
  const Home({Key  key,
    this.user}) :super(key : key);
  _MyHomePageState createState() => _MyHomePageState(user);
}

class _MyHomePageState extends State<Home>{
  FirebaseUser user;
  _MyHomePageState(this.user);

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) =>  AlertDialog(
        title:  Text('Are you sure?'),
        content:  Text('Do you want to exit GnuCash'),
        actions: <Widget>[
          InkWell(
            onTap: () => Navigator.of(context).pop(false),
            child: roundedButton("No", Colors.green,
                Colors.white),
          ),
           InkWell(
            onTap: () => Navigator.of(context).pop(true),
            child: roundedButton(" Yes ", Colors.green,
                Colors.white),
          ),
        ],
      ),
    ) ??
        false;
  }

  Widget roundedButton(String buttonLabel, Color bgColor, Color textColor) {
    var loginBtn =  Container(
      padding: EdgeInsets.all(5.0),
      alignment: FractionalOffset.center,
      decoration:  BoxDecoration(
        color: bgColor,
        borderRadius:  BorderRadius.all(const Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.lightGreen,
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style:  TextStyle(
            color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }

  String _key = '_drawer';

  void _signOut() async{
    await FirebaseAuth.instance.signOut();
    runApp(
      MaterialApp(
        home: Splash(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
      child: MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: GradientAppBar(
            title: Text('Accounts'),
            actions: <Widget>[
              CircleAvatar(
                child: Text('${user.email[0].toUpperCase()}'),
                radius: 20,
                backgroundColor: Colors.purple,
              ),

            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
                colors: [Colors.purple,Colors.pink]),
            bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: <Widget>[
                  //Tab(icon: Icon(Icons.android),),
                  Text('RECENT',style: TextStyle(
                      color: Colors.white,fontSize: 16
                  ),),
                  Text('ALL',style: TextStyle(
                      color: Colors.white,fontSize: 16
                  ),),
                  Text('FAVOURITES',style: TextStyle(
                      color: Colors.white,fontSize: 16
                  ),)
                ]
            ),
          ),
          body: Center(
            child:TabBarView(children: <Widget>[

              Text('No recent accounts',textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.indigoAccent,
                  fontSize: 20,
                  height: 20.0,
                ),
              ),

              StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('Accounts').snapshots(),
              builder: (context, snapshot) {
              // ignore: missing_return
              return snapshot.hasData?Accounts():Text('No accounts',textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.indigoAccent,
                  fontSize: 20,
                  height: 20.0,
                ),);
              }),

              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('Accounts').snapshots(),
                  builder: (context, snapshot) {
                    // ignore: missing_return
                    return snapshot.hasData?Favourites():Text('No Favourite accounts',textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 20,
                        height: 20.0,
                      ),);
                  }),
            ]),
          ),

          drawer: Drawer(
            key: Key(_key),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 150,
                  child:DrawerHeader(
                    child:Wrap(children: <Widget>[
                      IconButton(icon:Image.asset('images/icon.png',color: Colors.white,),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),onPressed: (){},),
                    Text('GnuCash',style: TextStyle(
                        color: Colors.white,fontSize: 24,fontWeight: FontWeight.w400
                    ),),
                  ],),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [Colors.purple,Colors.pink]),),
                  ),
                ),

                ListTile(
                    title: Wrap(children: <Widget>[
                      IconButton(icon:Icon(Icons.folder_open),padding: EdgeInsets.all(0.0),alignment:
                      Alignment.topLeft,onPressed: (){

                      },),
                      Text('Open',style: TextStyle(
                        fontSize: 16
                      ),)
                    ],),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),

                Divider(
                  thickness: 0.5,
                ),
                ListTile(
                  title: Text('Accounts',style: TextStyle(
                      fontSize: 17,color: Colors.grey
                  )),
                ),


                ListTile(
                  title:Wrap(children: <Widget>[
                    IconButton(icon:Icon(Icons.star),padding: EdgeInsets.all(0.0),alignment:
                    Alignment.topLeft,onPressed: (){},),
                    Text('Favourites',style: TextStyle(
                        fontSize: 16
                    )),
                  ],),
                  onTap: (){
                  },
                  ),

                ListTile(
                    title: Wrap(children: <Widget>[
                  IconButton(icon:Icon(Icons.equalizer),padding: EdgeInsets.all(0.0),alignment:
                  Alignment.topLeft,onPressed: (){},),
                  Text('Reports',style: TextStyle(
                      fontSize: 16
                  )),
                ],),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Reports(),fullscreenDialog: true));
                  },
                ),
                Divider(
                  thickness: 0.5,
                ),

                ListTile(
                    title: Text('Transcations',style: TextStyle(
                        fontSize: 17,color: Colors.grey
                    ))
                ),
                ListTile(
                  title: Wrap(children: <Widget>[
                    IconButton(icon:Icon(Icons.settings_backup_restore),
                      padding: EdgeInsets.all(0.0),alignment:
                    Alignment.topLeft,onPressed: (){},),
                    Text('Scheduled Actions',style: TextStyle(
                        fontSize: 16
                    )),
                  ],),
                  onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Schedule()));
                  },
                ),
                ListTile(
                  title: Wrap(children: <Widget>[
                    IconButton(icon:Icon(Icons.cloud_upload),padding: EdgeInsets.all(0.0),alignment:
                    Alignment.topLeft,onPressed: (){},),
                    Text('Export...',style: TextStyle(
                        fontSize: 16
                    )),
                  ],),
                  onTap: (){

                  },

                ),
                Divider(
                  thickness: 0.5,
                ),


                ListTile(
                    title: Text('Preferences',style: TextStyle(
                        fontSize: 17,color: Colors.grey
                    ))
                ),
                ListTile(
                  title: Wrap(children: <Widget>[
                    IconButton(icon:Icon(Icons.settings),padding: EdgeInsets.all(0.0),alignment:
                    Alignment.topLeft,onPressed: (){},),
                    Text('Settings',style: TextStyle(
                        fontSize: 16
                    )),
                  ],),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                  },
                ),
                ListTile(
                  title:Wrap(children: <Widget>[
                    IconButton(icon:Icon(Icons.help),padding: EdgeInsets.all(0.0),alignment:
                    Alignment.topLeft,onPressed: (){},),
                    Text('Help & Feedback',style: TextStyle(
                        fontSize: 16
                    )),
                  ],),
                  onTap: (){

                  },
                ),
                ListTile(
                  title:Wrap(children: <Widget>[
                    IconButton(icon:Icon(Icons.power_settings_new),padding: EdgeInsets.all(0.0),alignment:
                    Alignment.topLeft,onPressed: (){},),
                    Text('Logout',style: TextStyle(
                        fontSize: 16
                    )),
                  ],),
                  onTap: (){
                    _signOut();
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.pinkAccent,
              child: Icon(Icons.add,color: Colors.white,),
              onPressed:
                  (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AddAccount(),fullscreenDialog: true));
              }
          ),
        ),
      ),)
    );
  }
}