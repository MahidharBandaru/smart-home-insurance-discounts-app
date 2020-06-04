import 'package:flutter/material.dart';

class AppDrawer  extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:ListView(children: <Widget>[
        DrawerHeader(
          child:null,
          ),
          ListTile(
            leading:Icon(Icons.home),
            title:Text('Purchase Policy'),
            onTap:(){
              Navigator.of(context).pop();
            }),
          ListTile(
            leading:Icon(Icons.money_off),
            title:Text('Smart Devices Discounts'),
            onTap:(){
              Navigator.of(context).pop();
            }),
            ListTile(
            leading:Icon(Icons.devices),
            title:Text('My Devices'),
            onTap:(){
              Navigator.of(context).pop();
            }),
          ListTile(
            leading:Icon(Icons.phone),
            title:Text('Connect With Us'),
            onTap:(){
              Navigator.of(context).pop();
            }),

      ],
      ),
      
    );
  }
}