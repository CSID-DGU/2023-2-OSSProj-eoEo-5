import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/User.dart';
import '../model/chartdata.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/module/Request.dart' as rq;

class ChartWidget extends StatefulWidget {
  ChartWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ChartWidget createState() => _ChartWidget();

}

class _ChartWidget extends State<ChartWidget> {
  bool isChartDataLoaded = false;
  Map<String, List<List>> chartData = {};

  @override
  void initState() {
    super.initState();
    takenload().then((lectures) {
      chartData = lectures;
      setState(() {
        isChartDataLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isChartDataLoaded) {
      return ChartScreen(getData(chartData));
    }
    else {
      return Container();
    }
  }

  //Map<String, List<List>> chartData
  Widget ChartScreen(List<data> _chartData) {
    return SafeArea(
        child: Container(
            width: 380,
            height: 380,
            child: SfCircularChart(
              series: <CircularSeries>[
                RadialBarSeries<data, String>(
                    dataSource: _chartData,
                    xValueMapper: (data data, _) => data.section,
                    yValueMapper: (data data, _) => data.credit,
                    pointColorMapper: (data data, _) {
                      if (data.section == "major") {
                        return Colors.blueAccent;
                      } else if (data.section == "double major") {
                        return Colors.greenAccent;
                      } else if (data.section == "liberal arts") {
                        return Colors.yellowAccent;
                      }
                    },
                    cornerStyle: CornerStyle.bothCurve,
                    maximumValue: 100
                )
              ],
              annotations: <CircularChartAnnotation>[
                CircularChartAnnotation(
                  widget: Container(
                    child: Text(
                      '전공: ${_chartData[0].credit}%\n복수전공: ${_chartData[1]
                          .credit}%\n교양: ${_chartData[2].credit}%',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87
                      ),
                    ),
                  ),
                  angle: 90, // 원의 중심에서 원 주변으로 레이블을 배치하는 각도
                ),
              ],
            )
        )
    );
  }

  Future<Map<String, List<List>>> takenload() async {
    SharedPreferences pref = await SharedPreferences
        .getInstance(); // SharedPreferences 인스턴스 생성
    User user = User.fromJson(jsonDecode(pref.getString("user")!)); // 사용자 정보
    int? takenCourseId = user.id; // 사용자의 기수강 ID

    // 기수강 중 주전공 api 요청
    List<List> response1 = [];
    http.Response? takenLectures1 = await rq.Request
        .getRequest( // 서버에서 강의 정보 분류 요청
        "https://eoeoservice.site/lecture/getfirstmajorlecturetaken",
        {"userId": "$takenCourseId"}, // 기수강 ID를 파라미터로 전달
        true,
        true,
        context);
    // 기수강 과목 리스트: 주전공
    List takenLectureList = jsonDecode(
        utf8.decode(takenLectures1!.bodyBytes)); // 응답데이터 디코딩
    response1.add(takenLectureList);

    // 기수강 중 복수전공 api 요청
    List<List> response2 = [];
    http.Response? takenLectures2 = await rq.Request
        .getRequest( // 서버에서 강의 정보 분류 요청
        "https://eoeoservice.site/lecture/getcorelecturetaken",
        {"userId": "$takenCourseId"}, // 기수강 ID를 파라미터로 전달
        true,
        true,
        context);
    // 기수강 과목 리스트: 복수전공
    List takenLectureList2 = jsonDecode(
        utf8.decode(takenLectures2!.bodyBytes)); // 응답데이터 디코딩
    response2.add(takenLectureList2);

    // 기수강 중 교양 api 요청
    List<List> response3 = [];
    http.Response? takenLectures3 = await rq.Request
        .getRequest( // 서버에서 강의 정보 분류 요청
        "https://eoeoservice.site/lecture/getcorelecturetaken",
        {"userId": "$takenCourseId"}, // 기수강 ID를 파라미터로 전달
        true,
        true,
        context);
    // 기수강 과목 리스트: 교양
    List takenLectureList3 = jsonDecode(
        utf8.decode(takenLectures3!.bodyBytes)); // 응답데이터 디코딩
    response3.add(takenLectureList3);

    Map<String, List<List>> lectures = {
      "firstmajor": response1,
      "secondmajor": response2,
      "corelecture": response3
    };

    return lectures; // 맵형식
  }


  List<data> getData(Map<String, List<List>> lectures) {
    double major = 0;
    double doublemajor = 0;
    double liberalarts = 0;

    for (int i = 0; i < lectures['firstmajor']![0].length; i++) {
      major += lectures['firstmajor']![0][i]['credit'];
    }
    major = ((major / 54) * 100).floorToDouble();

    for (int i = 0; i < lectures['secondmajor']![0].length; i++) {
      doublemajor += lectures['secondmajor']![0][i]['credit'];
    }
    doublemajor = ((doublemajor / 36) * 100).floorToDouble();

    for (int i = 0; i < lectures['corelecture']![0].length; i++) {
      liberalarts += lectures['corelecture']![0][i]['credit'];
    }
    liberalarts = ((liberalarts / 36) * 100).floorToDouble();

    final List<data> chartData = [
      data('major', major),
      data('double major', doublemajor),
      data('liberal arts', liberalarts),
    ];
    return chartData;
  }
}