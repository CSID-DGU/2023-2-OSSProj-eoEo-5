import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/data/User.dart';
import 'package:frontend/module/Request.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Subject_takenScreen extends StatefulWidget {
  @override
  _Subject_takenScreen createState() => _Subject_takenScreen(); // 상태 클래스 반환
}

/*

1. 서버에서 response응답을 받아옴
2. lectureList에 response 저장
3. renderWidgets 메서드에 response

 */

class _Subject_takenScreen extends State<Subject_takenScreen> { // Subject_takenScreen 위젯의 상태 클래스
  bool isDataLoaded = false; // 데이터가 로드되었는지 여부를 나타내는 플래그
  List<Widget> takenLectureWidgets = []; // 컨테이너에 띄울 리스트 위젯
  late List<List> lectureList; // 리스트를 담을 리스트

  @override
  void initState() { // 초기화 메서드

    super.initState();
    loadLectures().then((response) { // 강의 정보를 불러오는 비동기 함수 호출
      lectureList = response; // 불러온 강의 정보를 lectureList에 저장
      renderWidgets(response); // 강의 정보를 위젯으로 렌더링
      setState(() {
        isDataLoaded = true; // 데이터가 로드되었음을 표시
      });
    });
  }

  @override
  Widget build(BuildContext context) { // 위젯 빌드 메서드
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
            '기수강 과목',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Text("기수강 과목", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Column(
                children: takenLectureWidgets,
              )
            ])));
  }

  Future<List<List>> loadLectures() async { // 강의 정보를 불러오는 비동기 함수
    List<List> response = []; // 응답 데이터를 담을 2차원 리스트
    SharedPreferences pref = await SharedPreferences.getInstance(); // SharedPreferences 인스턴스 생성
    User user = User.fromJson(jsonDecode(pref.getString("user")!)); // 사용자 정보
    int? takenCourseId = user.id; // 사용자의 기수강 ID

    http.Response? takenLectures = await Request.getRequest( // 서버에 강의 정보 요청
        "https://eoeoservice.site/lecture/getlecturetaken",
        {"userId": "$takenCourseId"}, // 기수강 ID를 파라미터로 전달
        true,
        true,
        context);

    List takenLectureList = jsonDecode(utf8.decode(takenLectures!.bodyBytes)); // 응답데이터 디코딩

    response.add(takenLectureList);

    return response;
  }

  void renderWidgets(List<List> lectures) {// 리스트를 위젯으로 렌더링하는 메소드
    takenLectureWidgets = [];

    for (int i = 0; i < lectures[0].length; i++) { // 리스트 테이블
      takenLectureWidgets.add(
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  lectures[0][i]['name'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
            ],
          )
      );
    }
  }
}



