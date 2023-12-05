import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/module/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/textwriter.dart';

class ShowUser extends StatefulWidget {

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  late SharedPreferences pref;
  bool isUserDataLoaded = false;

  //
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
      return showUser();
    } else{
      return Container();
    }
  }

  Widget showUser(){
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    User user = User.fromJson(jsonDecode(pref.getString("user")!));
    String? name = user.name;
    String? major = user.major;

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: TextWriter(width: 0, fontSize: 18, contents:"USER", fontWeight:FontWeight.bold, textColor: Colors.white),
          ),
          body: Column(
            children: <Widget>[
              TextWriter(width:width, fontSize:20, contents: "$name", textColor: Colors.black, fontWeight: FontWeight.bold),
              TextWriter(width: width, fontSize: 18, contents:"$major", fontWeight:FontWeight.bold, textColor: Colors.black),
            ]
          ),
      )
    );
  }
}