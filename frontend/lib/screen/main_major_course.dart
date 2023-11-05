import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/data/User.dart';
import 'package:frontend/module/Request.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainMajorCourse extends StatefulWidget {
  @override
  _MainMajorCourseState createState() => _MainMajorCourseState();
}

class _MainMajorCourseState extends State<MainMajorCourse> {
  bool isDataLoaded = false;
  List<Widget> requiredLectureWidgets = [];
  List<Widget> selectiveLectureWidgets = [];

  late List<List> lectureList;

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text(
            '주전공 : 경영학과 이수체계도 보기',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
            child: Column(children: [
          Text("전공필수", style: TextStyle(fontSize: 24)),
          Column(
            children: requiredLectureWidgets,
          ),
          Text("전공선택", style: TextStyle(fontSize: 24)),
          Column(
            children: selectiveLectureWidgets,
          )
        ])));
  }

  Future<List<List>> loadLectures() async {
    List<List> response = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    User user = User.fromJson(jsonDecode(pref.getString("user")!));
    int? requiredCourseId = user.requiredCourseId;
    int? selectiveCourseId = user.selectiveCourseId;

    print(requiredCourseId);

    http.Response? requiredLectures = await Request.getRequest(
        "https://eoeoservice.site/course/getcourselectures",
        {"courseId": "$requiredCourseId"},
        true,
        true,
        context);
    http.Response? selectiveLectures = await Request.getRequest(
        "https://eoeoservice.site/course/getcourselectures",
        {"courseId": "$selectiveCourseId"},
        true,
        true,
        context);

    List requiredLectureList =
        jsonDecode(utf8.decode(requiredLectures!.bodyBytes));
    List selectiveLectureList =
        jsonDecode(utf8.decode(selectiveLectures!.bodyBytes));

    response.add(requiredLectureList);
    response.add(selectiveLectureList);

    return response;
  }

  void renderWidgets(List<List> lectures) {
    print(lectures);
    requiredLectureWidgets = [];
    selectiveLectureWidgets = [];
    for (int i = 0; i < lectures[0].length; i++) {
      requiredLectureWidgets.add(Container(
          width: MediaQuery.of(context).size.width,
          child: Text(lectures[0][i]['lectureName'],
              style: TextStyle(fontSize: 20))));
    }

    for (int i = 0; i < lectures[1].length; i++) {
      selectiveLectureWidgets.add(Container(
          width: MediaQuery.of(context).size.width,
          child: Text(lectures[1][i]['lectureName'],
              style: TextStyle(fontSize: 20))));
    }
  }
}
