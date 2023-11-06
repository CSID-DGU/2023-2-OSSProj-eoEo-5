import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/data/User.dart';
import 'package:frontend/module/Request.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Subject_takenScreen extends StatefulWidget {
  @override
  _Subject_takenScreen createState() => _Subject_takenScreen();
}

class _Subject_takenScreen extends State<Subject_takenScreen> {
  bool isDataLoaded = false;
  List<Widget> takenLectureWidgets = [];
  late List<List> lectureList;

  late SharedPreferences pref;
  bool isUserDataLoaded = false;

  @override
  void initState() {

    super.initState();

    SharedPreferences.getInstance().then((response){
      pref = response;
      setState(() {
        isUserDataLoaded = true;
      });
    });

    loadLectures().then((response) {
      lectureList = response;
      renderWidgets(response);
      setState(() {
        isDataLoaded = true;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    if (isDataLoaded) {
      return renderScreen();
    } else {
      return Container();
    }
  }

  Widget renderScreen() {

    User user = User.fromJson(jsonDecode(pref.getString("user")!));

    String name = user.name;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text(
            '기수강 과목입니다.',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
            child: Column(children: [
              Text("기수강 과목", style: TextStyle(fontSize: 24)),
              Column(
                children: takenLectureWidgets,
              )
            ])));
  }

  Future<List<List>> loadLectures() async {
    List<List> response = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    User user = User.fromJson(jsonDecode(pref.getString("user")!));
    int? id = user.id;

    http.Response? takenLectures = await Request.getRequest(
        "https://eoeoservice.site/lecture/getlecturetaken",
        {"id": "$id"},
        true,
        true,
        context);

    List takenLectureList =
    jsonDecode(utf8.decode(takenLectures!.bodyBytes));

    response.add(takenLectureList);

    return response;
  }

  void renderWidgets(List<List> lectures) {
    takenLectureWidgets = [];

    for (int i = 0; i < lectures[0].length; i++) {
      takenLectureWidgets.add(Container(
          width: MediaQuery.of(context).size.width,
          child: Text(lectures[0][i]['lectureName'],
              style: TextStyle(fontSize: 20))));
    }
  }
}





