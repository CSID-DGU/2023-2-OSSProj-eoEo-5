import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/textwriter.dart';

class ShowUser extends StatefulWidget {

  @override
  State<ShowUser> createState() => _ShowUserState();

}

class _ShowUserState extends State<ShowUser> {
  late SharedPreferences pref;
  bool isUserDataLoaded = false;

  @override
  void initState(){
    SharedPreferences.getInstance().then((response){
      pref = response;
      setState(() {
        isUserDataLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(isUserDataLoaded){
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
            "USER",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0.8,
          ),
          body: showUser(),
        ),
      );
    } else{
      return Container();
    }
  }

  Widget showUser(){
    User user = User.fromJson(jsonDecode(pref.getString("user")!));
    String? username = user.username;
    String? major = user.major;
    String? secondmajor = user.secondMajor;


    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Column(
            children: <Widget>[
              TextWriter(width:width, fontSize:20, contents: "$username", textColor: Colors.black, fontWeight: FontWeight.bold),
              TextWriter(width: width, fontSize: 18, contents:"$major", fontWeight:FontWeight.bold, textColor: Colors.black),
              TextWriter(width: width, fontSize: 18, contents:"$secondmajor", fontWeight:FontWeight.bold, textColor: Colors.black),
            ]
          );
    }
}