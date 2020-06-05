import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/home.dart';
import 'package:homeinsuranceapp/pages/login_screen.dart';
import 'package:homeinsuranceapp/pages/get_home_details.dart';

void main() {
  runApp(MyApp());
}

// This class is used to store all routes and takes the user to the page corresponding to initial route ('/)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home',
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        '/': (context) => HomePage(),
        '/gethomedetails': (context) => HomeDetails(),
      },
    );
  }
}
