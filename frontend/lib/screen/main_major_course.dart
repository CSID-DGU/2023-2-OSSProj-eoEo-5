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
  late List<List> lectureinfo;

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
                children: requiredLectureWidgets,
              ),
              Padding(padding: const EdgeInsets.all(20.0),),
              Text("전공선택", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Column(
                children: selectiveLectureWidgets,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<List>> loadLectures() async {
    List<List> response = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    User user = User.fromJson(jsonDecode(pref.getString("user")!));
    int? requiredCourseId = user.requiredCourseId;
    int? selectiveCourseId = user.selectiveCourseId;

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

    List requiredLectureList = jsonDecode(utf8.decode(requiredLectures!.bodyBytes));
    List selectiveLectureList = jsonDecode(utf8.decode(selectiveLectures!.bodyBytes));

    response.add(requiredLectureList);
    response.add(selectiveLectureList);

    return response;
  }

  void renderWidgets(List<List> lectures) {
    requiredLectureWidgets = [];
    selectiveLectureWidgets = [];

    for (int i = 0; i < lectures[0].length; i++) {
      String? requiredname;
      requiredname = lectures[0][i]['lectureName'];
      requiredLectureWidgets.add(
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: () {
                  lectureinfoList(requiredname!, true);
                },
                child: Text(
                  requiredname!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(),
          ],
        ),
      );
    }

    for (int i = 0; i < lectures[1].length; i++) {
      String? selectivename;
      selectivename = lectures[1][i]['lectureName'];
      selectiveLectureWidgets.add(
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: () {
                  lectureinfoList(selectivename!, false);
                },
                child: Text(
                  selectivename!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(),
          ],
        ),
      );
    }
  }

  Future<void> lectureinfoList(String lecturename, bool isrequired) async {
    List<List> LectureInfoList = [];
    String? lectureNumber;
    List? preSubjectName = [];
    List? preSubjectNumber = [];
    List? substitutelectureName = [];
    List? substitutelectureNumber = [];
    int? lectureCredit;
    int? lectureId;

    if (isrequired) {
      for (int i = 0; i < lectureList[0].length; i++) {
        if (lectureList[0][i]['lectureName'] == lecturename) {
          lectureNumber = lectureList[0][i]['lectureNumber'];
          lectureId = lectureList[0][i]['lectureId'];
          lectureCredit = lectureList[0][i]['credit'];
        }
      }
    } else {
      for (int i = 0; i < lectureList[1].length; i++) {
        if (lectureList[1][i]['lectureName'] == lecturename) {
          lectureNumber = lectureList[1][i]['lectureNumber'];
          lectureId = lectureList[1][i]['lectureId'];
          lectureCredit = lectureList[1][i]['credit'];
        }
      }
    }

    http.Response? preSubjectresponse = await Request.getRequest(
        "https://eoeoservice.site/lecture/getprerequisites",
        {"lectureId": "$lectureId"},
        true,
        true,
        context);

    http.Response? substitutelectureresponse = await Request.getRequest(
        "https://eoeoservice.site/lecture/getsubstitutes",
        {"lectureId": "$lectureId"},
        true,
        true,
        context);

    List preSubjectList = jsonDecode(utf8.decode(preSubjectresponse!.bodyBytes));
    List substitutelectureList = jsonDecode(utf8.decode(substitutelectureresponse!.bodyBytes));

    for (int j = 0; j < preSubjectList.length; j++) {
      preSubjectName.add(preSubjectList[j]["name"]);
      preSubjectNumber.add(preSubjectList[j]["lectureNumber"]);
    }

    for (int k = 0; k < substitutelectureList.length; k++) {
      substitutelectureName.add(substitutelectureList[k]["name"]);
      substitutelectureNumber.add(substitutelectureList[k]["lectureNumber"]);
    }

    LectureInfoList.add(preSubjectName);
    LectureInfoList.add(preSubjectNumber);
    LectureInfoList.add(substitutelectureName);
    LectureInfoList.add(substitutelectureNumber);

    // 로그 테스트
    print(lecturename);
    print(lectureNumber);
    print(lectureCredit);
    print(lectureId);
    print(LectureInfoList);

    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 700,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text('과목명: $lecturename', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Text('학수번호: $lectureNumber', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Text('학점: $lectureCredit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          child: Text(
                            '선이수과목',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          child: Text(
                            generateSubjectText(LectureInfoList[0], LectureInfoList[1]),
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          child: Text(
                            '대체과목',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          child: Text(
                            generateSubjectText(LectureInfoList[2], LectureInfoList[3]),
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  child: const Text('확인', style: TextStyle(fontWeight: FontWeight.bold),),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  String generateSubjectText(List<dynamic> names, List<dynamic> numbers) {
    List<String> subjects = [];
    for (int i = 0; i < names.length; i++) {
      subjects.add('[${names[i]}, ${numbers[i]}]\n');
    }
    return subjects.join(' ');
  }
}

