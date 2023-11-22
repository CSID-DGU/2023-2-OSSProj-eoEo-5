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
  late List<data> _chartData;
  List<Widget> takenLectureWidgets = []; // 컨테이너에 띄울 리스트 위젯

  @override
  void initState() {
    someFunction(); // initState에서 비동기 작업 수행
   // _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            width: 380,
            height: 380,
            child: SfCircularChart(
              series: <CircularSeries>[
                //DoughnutSeries<data, String>(
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
                    //radius: BorderRadius.all(Radius.circuler(15)),
                    //borderRadius: BorderRadius.all(Radius.circular(15)),
                    maximumValue: 90
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

  Future<List<List>> loadLectures() async {

    List<List> response = [];
    SharedPreferences pref = await SharedPreferences
        .getInstance(); // SharedPreferences 인스턴스 생성
    User user = User.fromJson(jsonDecode(pref.getString("user")!)); // 사용자 정보
    int? takenCourseId = user.id; // 사용자의 기수강 ID

    // 기수강 중 주전공 api 요청
    http.Response? takenLectures = await rq.Request.getRequest( // 서버에서 강의 정보 분류 요청
        "https://eoeoservice.site/lecture/getfirstmajorlecturetaken",
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

    List<data> chartData = getChartData(lecturesData);
    setState(() {
      _chartData = chartData; // _chartData를 업데이트하고 화면을 리프레시

      }
    );
  }
}


  // 2차원 리스트를 파라미터로 받아서 수치를 더한 후, data 클래스에 입력하는 코드
  List<data> getChartData(List<List> lectures) {

    double major = 0;
    double doublemajor = 0;
    double liberalarts = 0;

    for (int i = 0; i < lectures[0].length; i++) { // 리스트 테이블
      major += lectures[0][i]['credit'];
      doublemajor += lectures[0][i]['credit'];
      liberalarts += lectures[0][i]['credit'];
    }

    final List<data> chartData = [
      data('major', major),
      data('double major', doublemajor),
      data('liberal arts', liberalarts),
    ];

    return chartData;
  }


