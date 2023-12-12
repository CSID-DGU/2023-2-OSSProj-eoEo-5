import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/module/Request.dart' as rq;
import 'package:fl_chart/fl_chart.dart';


import '../data/User.dart';

class ChartWidget extends StatefulWidget {
  ChartWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ChartWidget createState() => _ChartWidget();
}

class _ChartWidget extends State<ChartWidget> {
  late User user;
  bool isChartDataLoaded = false;
  Map<String, List<List>> chartData = {};

/*
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

 */

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((response){
      user = User.fromJson(jsonDecode(response.getString("user")!));
      takenload().then((lectures) {
        chartData = lectures;
        setState(() {
          isChartDataLoaded = true;
        });
      });
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isChartDataLoaded) {
      return ChartScreen(getData(chartData));
    } else {
      return Container();
    }
  }

  @override
  void didUpdateWidget(ChartWidget oldWidget){
    super.didUpdateWidget(oldWidget);
    takenload().then((lectures) {
      chartData = lectures;
      setState(() {
        isChartDataLoaded = true;
      });
    });
  }

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    String text = '';
    switch (value.toInt()) {
      case 0:
        text = '전공';
        break;
      case 1:
        text = '복수전공';
        break;
      case 2:
        text = '교양';
        break;
      default:
        text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }


  Widget ChartScreen(List<Data> _chartData) {
    return SafeArea(
      child: Container(
        width: 380,
        height: 350,
        child: BarChart(
          BarChartData(
            // max 값
            maxY: 100,
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.transparent,
                tooltipPadding: EdgeInsets.zero,
                tooltipMargin: 8,
                getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                    ) {
                  return BarTooltipItem(
                    rod.toY.round().toString()+'%',
                    const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: getTitles,
                ),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: _chartData
                .asMap()
                .entries
                .map(
                  (entry) => BarChartGroupData(
                x: entry.key,
                barsSpace: 4,
                barRods: [
                  BarChartRodData(
                    width: 35,
                    toY: entry.value.credit,
                    color: getBarColor(entry.key), // 각 막대의 색상을 함수로 지정
                  ),
                ],
                showingTooltipIndicators: [0],
              ),
            )
                .toList(),
            gridData: FlGridData(show: false),
            alignment: BarChartAlignment.spaceAround,
          ),
        ),
      ),
    );
  }

  Color getBarColor(int index) {
    // 여기서 index에 따라 다른 색상을 반환할 수 있습니다.
    switch (index) {
      case 0:
        return Colors.blue; // 전공
      case 1:
        return Colors.greenAccent; // 복수전공
      case 2:
        return Colors.yellowAccent; // 교양
      default:
        return Colors.blue; // 기본값
    }
  }



  Future<Map<String, List<List>>> takenload() async {
    //SharedPreferences pref = await SharedPreferences.getInstance();
    //User user = User.fromJson(jsonDecode(pref.getString("user")!));
    int? takenCourseId = user.id;

    List<List> response1 = [];
    http.Response? takenLectures1 = await rq.Request.getRequest(
      "https://eoeoservice.site/lecture/getfirstmajorlecturetaken",
      {"userId": "$takenCourseId"},
      true,
      true,
      context,
    );
    List takenLectureList = jsonDecode(utf8.decode(takenLectures1!.bodyBytes));
    response1.add(takenLectureList);

    List<List> response2 = [];
    http.Response? takenLectures2 = await rq.Request.getRequest(
      "https://eoeoservice.site/lecture/getsecondmajorlecturetaken",
      {"userId": "$takenCourseId"},
      true,
      true,
      context,
    );
    List takenLectureList2 = jsonDecode(utf8.decode(takenLectures2!.bodyBytes));
    response2.add(takenLectureList2);

    List<List> response3 = [];
    http.Response? takenLectures3 = await rq.Request.getRequest(
      "https://eoeoservice.site/lecture/getcorelecturetaken",
      {"userId": "$takenCourseId"},
      true,
      true,
      context,
    );
    List takenLectureList3 = jsonDecode(utf8.decode(takenLectures3!.bodyBytes));
    response3.add(takenLectureList3);

    Map<String, List<List>> lectures = {
      "firstmajor": response1,
      "secondmajor": response2,
      "corelecture": response3,
    };

    return lectures;
  }

  List<Data> getData(Map<String, List<List>> lectures) {
    double major = 0;
    double doublemajor = 0;
    double liberalarts = 0;

    for (int i = 0; i < lectures['firstmajor']![0].length; i++) {
      major += lectures['firstmajor']![0][i]['credit'];
    }
    major = ((major / user.totalFirstMajorCredit) * 100).floorToDouble();

    for (int i = 0; i < lectures['secondmajor']![0].length; i++) {
      doublemajor += lectures['secondmajor']![0][i]['credit'];
    }
    doublemajor = ((doublemajor / user.totalSecondMajorCredit) * 100).floorToDouble();

    for (int i = 0; i < lectures['corelecture']![0].length; i++) {
      liberalarts += lectures['corelecture']![0][i]['credit'];
    }
    liberalarts = ((liberalarts / user.totalCoreLectureCredit) * 100).floorToDouble();

    final List<Data> chartData = [
      Data('Major', major),
      Data('Double Major', doublemajor),
      Data('Liberal Arts', liberalarts),
    ];
    return chartData;
  }
}

class Data {
  final String section;
  final double credit;

  Data(this.section, this.credit);
}



