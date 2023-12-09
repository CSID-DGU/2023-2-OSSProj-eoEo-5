import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:frontend/data/User.dart';
import 'package:frontend/module/Request.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DoubleMajorCourse extends StatefulWidget {
  @override
  _DoubleMajorCourseState createState() => _DoubleMajorCourseState();
}

class _DoubleMajorCourseState extends State<DoubleMajorCourse>{
  bool isDataLoaded = false; // 데이터가 로드되었는지 여부를 나타내는 플래그
  List<Widget> requiredLectureWidgets = []; // 전공필수 강의 위젯 목록
  List<Widget> selectiveLectureWidgets = []; // 전공선택 강의 위젯 목록

  late List<List> lectureList;

  @override
  void initState() { // 초기화 메서드
    super.initState();

    loadLectures().then((response) { // 강의 정보를 불러오는 비동기 함수 호출
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
        backgroundColor: Colors.blue,
        title: Text(
          "주전공 이수체계도",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.8,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("전공필수", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Column(
                // 전공필수 강의 위젯 목록 표시
                children: requiredLectureWidgets,
              ),
              Padding(padding: const EdgeInsets.all(20.0),),

              Text("전공선택", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Column(
                // 전공선택 강의 위젯 목록 표시
                children: selectiveLectureWidgets,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<List>> loadLectures() async { // 강의정보 불러오는 비동기 함수
    List<List> response = []; // 위젯에 렌더링할 리스트
    SharedPreferences pref = await SharedPreferences.getInstance(); // shared prefere
    // 사용자 데이터
    User user = User.fromJson(jsonDecode(pref.getString("user")!));
    // 사용자 데이터: 주전공, 족수전공 id
    int? secondrequiredCourseId = user.secondRequiredCourseId;
    int? secondselectiveCourseId = user.secondSelectiveCourseId;
    print(secondrequiredCourseId);
    print(secondselectiveCourseId);

    // 필수 강의 정보를 가져오는 HTTP 요청
    http.Response? requiredLectures = await Request.getRequest(
        "https://eoeoservice.site/course/getcourselectures",
        {"courseId": "$secondrequiredCourseId"},
        true,
        true,
        context);
    // 선택 강의 정보를 가져오는 HTTP 요청
    http.Response? selectiveLectures = await Request.getRequest(
        "https://eoeoservice.site/course/getcourselectures",
        {"courseId": "$secondselectiveCourseId"},
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
    requiredLectureWidgets = [];
    selectiveLectureWidgets = [];


    for (int i = 0; i < lectures[0].length; i++) {
      requiredLectureWidgets.add(
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  onPressed: (){},
                  child: Text(
                    lectures[0][i]['lectureName'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ),
              ),
              Divider(),
            ],
          )

      );
    }

    for (int i = 0; i < lectures[1].length; i++) {
      selectiveLectureWidgets.add(
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  onPressed: (){},
                  child: Text(lectures[1][i]['lectureName'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Divider(),

            ],
          )
      );
    }
  }

}