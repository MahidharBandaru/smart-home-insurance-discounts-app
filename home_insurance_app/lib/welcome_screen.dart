import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
//import 'constant.env';
import 'package:flutter_config/flutter_config.dart';

import 'dart:io';
//import '.env.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:homeinsuranceapp/components/rounded_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
//import 'package:homeinsuranceapp/constants.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
//Class id = new Class();
class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account){
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Home'),
      ),
      body: Center(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_currentUser != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: _currentUser,
            ),
            title: Text(_currentUser.displayName ?? ''),
            subtitle: Text(_currentUser.email ?? ''),
          ),
          RoundedButton(
            title: 'Log Out',
            colour: Colors.lightBlueAccent,
            onPressed: _handleSignOut,
          ),
          RoundedButton(
            title : 'Get Started',
            colour:Colors.blueAccent,
            onPressed: auth,

          ),
        ],
      );
    }
    else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          TypewriterAnimatedTextKit(
            text: ['Smart Home'],
            textStyle: TextStyle(
              fontSize: 45.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          Text('You are not logged in..'),
          SizedBox(
            height: 24.0,
          ),

          RoundedButton(
            title: 'Log In',
            colour: Colors.lightBlueAccent,
            onPressed: _handleSignIn,
          ),
        ],
      );
    }
  }

  Future<void> _handleSignIn() async{
    try{
      await _googleSignIn.signIn();
    }catch(error){
      print(error);
    }
  }

  Future<void> _handleSignOut() async{
    _googleSignIn.disconnect();
  }
  Future<void> auth ( )async{
//final String _clientId= DotEnv().env['CLIENT_ID'];
//final String  _clientSecret=  DotEnv().env['CLIENT_SECRET'];
//final String _url = DotEnv().env['CLIENT_URL'];
//final String _url2= DotEnv().env['CLIENT_URL2'];
//final String _scope = DotEnv().env['CLIENT_SCOPE'];
final String _clientId= FlutterConfig.get('CLIENT_ID') ;
final String  _clientSecret=  FlutterConfig.get('CLIENT_SECRET') ;
final String _url = FlutterConfig.get('URL') ;
final String _url2= FlutterConfig.get('URL2') ;
final String _scope =FlutterConfig.get('SCOPE');

//final String _clientId=  "482460250779-8mk7lco5njbim010jimu5u1c39iisod7.apps.googleusercontent.com";
     //final String _clientSecret= "-RSvp0BZvHjc6Pk05I_DpFeO";
   //final  String _url =  "https://accounts.google.com/o/oauth2/auth?client_id=482460250779-8mk7lco5njbim010jimu5u1c39iisod7.apps.googleusercontent.com&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fsdm.service&state=state";
    //final String _url2 =
        //'https://staging-smartdevicemanagement.sandbox.googleapis.com/v1/enterprises/akashag-step-interns-test/structures';
    List<String> _scopes = [_scope];
    Uri.parse(_url);

    var authClient = await clientViaUserConsent(
        ClientId(_clientId, _clientSecret), _scopes, (url) {
      launch(url);
    });

    final String a = authClient.credentials.accessToken.data;
    print("Access Token");
    print(a);


    final client = new http.Client();
    final response = await client.post(
      _url2,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $a'},
    );
    final responseJson = json.decode(response.body);

    print(responseJson['error']);

  }

}


