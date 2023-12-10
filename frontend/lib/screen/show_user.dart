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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
          ),
          body: showUser(),
        ),
      );
    } else{
      return Container();
    }
  }

  Widget showUser() {
    User user = User.fromJson(jsonDecode(pref.getString("user")!));
    String? username = user.username;
    String? major = user.major;
    String? secondmajor = user.secondMajor;

    return ListView.builder(
      itemCount: 3, // Number of items in the list (name, major, second major)
      itemBuilder: (context, index) {
        if (index == 0) {
          return ListTile(
            title: Text(
              "Name: $username",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        } else if (index == 1) {
          return ListTile(
            title: Text(
              "Major: $major",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        } else if (index == 2) {
          return ListTile(
            title: Text(
              "Second Major: $secondmajor",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        }
        return Container(); // Return an empty container for any unexpected index
      },
    );
  }

}