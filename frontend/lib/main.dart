import 'package:flutter/material.dart';
import 'package:frontend/screen/login.dart';
import 'package:frontend/screen/screen_home.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  late SharedPreferences pref;
  int loginState = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((response) async {
      loginState = checkUser(response);
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'eoEo App',
      home: renderHome(loginState),
    );
  }

  Widget renderHome(int loginState){
    if(loginState == 0){
      return Container();
    } else if(loginState == 1){
      return HomeScreen();
    } else{
      return LoginScreen();
    }
  }

  int checkUser(SharedPreferences pref) {
    bool isUser = pref.containsKey('user');
    if(isUser){
      return 1;
    } else{
      return 2;
    }
  }
}