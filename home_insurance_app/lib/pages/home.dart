import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/menubar.dart';
import 'dart:ui';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
  MediaQueryData mediaQuery = MediaQuery.of(context);
  double screenwidth= mediaQuery.size.width;
    return Scaffold(
      drawer:AppDrawer(), // Sidebar 
      appBar:AppBar(
        title:Text('Home Insurance Company'),
        centerTitle: true ,
        backgroundColor: Colors.brown,
        ),
      body:Stack(children: <Widget>[   
        Container(                        // Container will contain a blur background image 
          decoration:BoxDecoration(
            image:DecorationImage( 
              image:AssetImage('assets/HomePage.jpg'),
              fit:BoxFit.cover,
              )
            ),
            child:BackdropFilter(
              filter:ImageFilter.blur(sigmaX:2.0, sigmaY:2.0,),
              child:Container(             
                decoration:BoxDecoration(    //BoxDecoration required for setting the opacity why ?
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
          ),
        Container(
          child: Container(
            margin:EdgeInsets.only(top:15.0 , left:screenwidth/16,right:screenwidth/16), //Orientation compactible 
            padding:EdgeInsets.all(15.0),
            width:6*screenwidth/7,
            decoration:BoxDecoration(
              color:Colors.brown.withOpacity(0.5),
              shape:BoxShape.rectangle,
              borderRadius:BorderRadius.circular(10.0),
              ),
            child: Align(
              heightFactor: 1.0,
              child: Text(
                "All your protection under one roof .Take Home Insurance now and secure your future. Don't forget to exlore the exciting discounts available ",
                style:TextStyle(
                  color:Colors.white70,
                  fontWeight:FontWeight.bold,
                  fontSize:15.0,
                )
                ),
              ),
            ),
          ),
        ],
      ), 
    );
  }
}



