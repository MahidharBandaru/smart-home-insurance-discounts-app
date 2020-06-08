import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/home.dart';
import 'package:homeinsuranceapp/welcome_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_config/flutter_config.dart';


  void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    await FlutterConfig.loadEnvVariables();

    runApp(MyApp());
  }





class MyApp extends StatelessWidget {
  @override


  Widget build(BuildContext context) {
    print(1);
    print(FlutterConfig.get('URL2'));
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        '/': (context) => HomePage(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
      },

    );
  }
}