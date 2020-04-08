import 'package:flutter/material.dart';
import 'reports.dart';
import 'settings.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Schedule extends StatefulWidget {
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: GradientAppBar(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1,0.2, 0.5, 0.6, 0.9],
                    colors: [
                      Colors.pink,
                      Colors.pink,
                      Colors.pink,
                      Colors.indigo,
                      Colors.purple
                    ]),
                title: Text('Scheduled Actions'),
//                actions: <Widget>[
//                  InkWell(
//                      onTap: (){
//                      },
//                      child:Icon(Icons.search,size: 32.0,)
//                  )
//
//                ],
                bottom: TabBar(
                    indicatorColor: Colors.white,
                    tabs: <Widget>[
                      //Tab(icon: Icon(Icons.android),),
                      Text('TRANSACTIONS',style: TextStyle(
                          color: Colors.white,fontSize: 16
                      ),),
                      Text('EXPORTS',style: TextStyle(
                          color: Colors.white,fontSize: 16
                      ),),
                    ]
                ),
              ),
              body: Center(
                child:TabBarView(children: <Widget>[
                  Text('No recurring transactions to display',
                    textAlign: TextAlign.center,maxLines: 2,
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 20,
                      height: 20.0,
                    ),
                  ),

              Text('No scheduled exports to display',textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 20,
                  height: 20.0,
                ),
              ),
                ]),
              ),
              drawer: Drawer(

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
                              colors: [Colors.purple,Colors.pink]),
                        ),
                      ),
                    ),

                    ListTile(
                      title: Wrap(children: <Widget>[
                        IconButton(icon:Icon(Icons.folder_open),padding: EdgeInsets.all(0.0),alignment:
                        Alignment.topLeft,onPressed: (){},),
                        Text('Open',style: TextStyle(
                            fontSize: 16
                        ),)
                      ],),
                      onTap: (){

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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Reports('')));
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
                        IconButton(icon:Icon(Icons.settings_backup_restore),padding: EdgeInsets.all(0.0),alignment:
                        Alignment.topLeft,onPressed: (){},),
                        Text('Scheduled Actions',style: TextStyle(
                            fontSize: 16
                        )),
                      ],),
                      onTap: (){

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
                  ],
                ),
              ),
            ),
          ),
    );
  }
}