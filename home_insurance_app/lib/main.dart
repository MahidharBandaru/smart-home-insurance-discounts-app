import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/home.dart';
import 'package:homeinsuranceapp/welcome_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_config/flutter_config.dart';


void main() {
  Future main() async {
    await FlutterConfig.loadEnvVariables();
   //await DotEnv().load('constant.env');
    //...runapp
    runApp(MyApp());
  }

}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomePage(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
      },
    );
  }
}
