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
            title: TextWriter(width: 0, fontSize: 18, contents:"USER", fontWeight:FontWeight.bold, textColor: Colors.white),
          ),
          body: Column(
            children: <Widget>[
              ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1),
                   ),
                child: ElevatedButton(
                  style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                   ),
                  child: Text(
                    '내가 들은 과목 추가',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      ),
                   ),
                  onPressed: () {},
                  ),
                ),
          showUser(),
           ],
          ),
        ),
      );
    } else{
      return Container();
    }
  }

  Widget showUser(){
    User user = User.fromJson(jsonDecode(pref.getString("user")!));
    String? name = user.name;
    String? major = user.major;

    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Column(
            children: <Widget>[
              TextWriter(width:width, fontSize:20, contents: "$name", textColor: Colors.black, fontWeight: FontWeight.bold),
              TextWriter(width: width, fontSize: 18, contents:"$major", fontWeight:FontWeight.bold, textColor: Colors.black),
            ]
          );
    }

    // 기수강과목 추가 기능
    /*
    Future<boo> addlecturetaken(int id, list lectures) async {
    Map<int, list> addlecturetakendata = {
      "accountId":id
      "lectures":lectures
      };

     // api요청 코드

     // if id가 맞다면, 데이터 처리 후 true

    }
     */

}