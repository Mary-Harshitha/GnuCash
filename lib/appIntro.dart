import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'splashScreen.dart';

class Intro extends StatefulWidget{
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro>{

  List<PageViewModel> _getPages(){
    return [
      PageViewModel(
        titleWidget: Column(
          children: <Widget>[
            SizedBox(height: 100),
//            Text('GnuCash',textAlign: TextAlign.center,
//              style: TextStyle(fontWeight: FontWeight.w300,
//                  color: Colors.purple,fontSize: 54
//              )),
            SizedBox(height: 100),
          ],
        ),
        bodyWidget: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child:  Stack(
            //alignment: Alignment(x, y)
            children: <Widget>[
              Container(
                height: 370,width: 320,
                child: Card(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 230,),
                      Text('keep track of your financial transactions on the go..',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w400,
                            color: Colors.white,fontSize: 22
                        ),maxLines: 2,)
                    ],
                  ),
                  color: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)
                  ),
                ),
              ),
              Positioned(
                  left: 20.0,
                  right: 20.0,
                  bottom: 170.0,
                  child:  Container(
                    height: 500,
                    width: 100,
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 290,),
                          Image.asset('images/i1.gif',height: 170,width: 220,),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
        footer: Padding(
          padding: EdgeInsets.only(top: 140),
        child: Divider(thickness: 1,)
        ),
      ),

      PageViewModel(
        titleWidget: SizedBox(height: 200),
        bodyWidget: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child:  Stack(
            //alignment: Alignment(x, y)
            children: <Widget>[
              Container(
                height: 370,width: 320,
                child: Card(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 230,),
                      Text('keep track of your financial transactions on the go..',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w400,
                            color: Colors.white,fontSize: 22
                        ),maxLines: 2,)
                    ],
                  ),
                  color: Colors.indigoAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)
                  ),
                ),
              ),
              Positioned(
                  left: 20.0,
                  right: 20.0,
                  bottom: 170.0,
                  child:  Container(
                    height: 500,
                    width: 100,
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 290,),
                          Image.asset('images/iii.gif',height: 185,width: 220,),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
        footer: Padding(
            padding: EdgeInsets.only(top: 140),
            child: Divider(thickness: 1,)
        ),
      ),
      PageViewModel(
        titleWidget: SizedBox(height: 200),
        bodyWidget: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child:  Stack(
            //alignment: Alignment(x, y)
            children: <Widget>[
              Container(
                height: 370,width: 320,
                child: Card(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 230,),
                      Text('keep track of your financial transactions on the go..',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w400,
                            color: Colors.white,fontSize: 22
                        ),maxLines: 2,)
                    ],
                  ),
                  color: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)
                  ),
                ),
              ),
              Positioned(
                  left: 20.0,
                  right: 20.0,
                  bottom: 170.0,
                  child:  Container(
                    height: 500,
                    width: 100,
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 290,),
                          Image.asset('images/i3.gif',height: 170,width: 220,),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
        footer: Padding(
            padding: EdgeInsets.only(top: 140),
            child: Divider(thickness: 1,)
        ),
      ),


    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
          pages: _getPages(),
          skip: Text('Skip',style: TextStyle(
              color: Colors.purpleAccent,fontSize: 22,fontWeight: FontWeight.w300
          ),),
          next: Text('Next',style: TextStyle(
            color: Colors.purpleAccent,fontSize: 22,fontWeight: FontWeight.w300
          ),),

          globalBackgroundColor: Colors.white,
          showNextButton: true,
          showSkipButton: true,
          onDone: (){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) => Splash()));
          },
          done: Text('Start',style: TextStyle(
              color: Colors.purpleAccent,fontSize: 22,fontWeight: FontWeight.w300
          ),)
      ),
    );
  }
}
