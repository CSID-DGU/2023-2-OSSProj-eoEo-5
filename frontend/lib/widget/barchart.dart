import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/User.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/module/Request.dart' as rq;

class BarChart extends StatefulWidget {
  BarChart({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _BarChart createState() => _BarChart();
}

class _BarChart extends State<BarChart> {
  late List<BARData> _chartData;


  @override
  void initState() {
    someFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          width: 330,
          height: 60,
          child: Align(
            alignment: Alignment.centerLeft, // 왼쪽 정렬을 위해 Alignment.centerLeft 사용
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              series: <ChartSeries>[
                BarSeries<BARData, String>(
                  name: '',
                  dataSource: _chartData,
                  xValueMapper: (BARData data, _) => data.mydata,
                  yValueMapper: (BARData data, _) => data.ratio,
                  pointColorMapper: (BARData, _) {
                    if (BARData.mydata == "달성도") {
                      return Colors.blue;
                    }
                  },
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                )
              ],
              primaryXAxis:
              CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0,  color: Colors.white),
                  minorGridLines: const MinorGridLines(width: 0, color: Colors.white),
                  isVisible: false,
              ),
              primaryYAxis: NumericAxis(
                // 최대값을 100으로 설정
                maximum: 100,
                isVisible: false,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BARData> getChartData(List<List> lectures) {
    double major = 0;

    for (int i = 0; i < lectures[0].length; i++) { // 리스트 테이블
      major += lectures[0][i]['credit'];
    }

    major = ((major/130) * 100).floorToDouble();

    final List<BARData> chartData = [
      BARData('major', major),
    ];

    return chartData;
  }

  // 강의 정보를 불러오는 비동기 함수
  Future<List<List>> loadLectures() async {
    List<List> response = [];
    SharedPreferences pref = await SharedPreferences
        .getInstance(); // SharedPreferences 인스턴스 생성
    User user = User.fromJson(jsonDecode(pref.getString("user")!)); // 사용자 정보
    int? takenCourseId = user.id; // 사용자의 기수강 ID

    http.Response? takenLectures = await rq.Request.getRequest( // 서버에서 강의 정보 요청
        "https://eoeoservice.site/lecture/getlecturetaken",
        {"userId": "$takenCourseId"}, // 기수강 ID를 파라미터로 전달
        true,
        true,
        context);

    List takenLectureList = jsonDecode(
        utf8.decode(takenLectures!.bodyBytes)); // 응답데이터 디코딩

    response.add(takenLectureList);

    return response;
  }

  Future<void> someFunction() async {
    List<List> lecturesData = await loadLectures(); // 기수강 정보를 비동기로 받아옴

    List<BARData> chartData = getChartData(lecturesData);
    setState(() {
      _chartData = chartData; // _chartData를 업데이트하고 화면을 리프레시
    });
  }
}


class BARData {
  BARData(this.mydata, this.ratio);
  final String mydata;
  final double ratio;
}
