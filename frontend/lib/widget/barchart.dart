import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/User.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/module/Request.dart' as rq;
import 'package:fl_chart/fl_chart.dart';

class BarChartWidget extends StatefulWidget {
  BarChartWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _BarChartWidgetState createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  bool isBarChartDataLoaded = false;
  List<List> chartData = [];

  @override
  void initState() {
    super.initState();
    loadLectures().then((response) {
      chartData = response;
      setState(() {
        isBarChartDataLoaded = true;
        print(chartData);
        print("toY value: ${getChartData(chartData)[0].ratio}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isBarChartDataLoaded) {
      return CircularProgressIndicator();
    }
    return SafeArea(
      child: Container(
        width: 300,
        height: 50,
        child: BarChart(
          BarChartData(
            maxY: 100,
            alignment: BarChartAlignment.start, // 이 부분을 변경
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                ),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),

            borderData: FlBorderData(show: false),
            barGroups: getChartData(chartData)
                .asMap()
                .entries
                .map(
                  (entry) {
                print("BarGroupData: ${entry.value.ratio}");
                return BarChartGroupData(
                  x: entry.key,
                  barRods: [
                    BarChartRodData(
                      toY: entry.value.ratio, // 수정
                      width: 20,
                      color: Colors.cyan,
                    ),
                  ],
                );
              },
            ).toList(),

            gridData: FlGridData(show: false),
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.blueAccent,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    rod.toY.round().toString(),
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BARData> getChartData(List<List> lectures) {
    double major = 0;
    for (int i = 0; i < lectures[0].length; i++) {
      major += lectures[0][i]['credit'];
    }
    major = ((major / 130) * 100).floorToDouble();
    final List<BARData> chartData = [
      BARData('major', major),
    ];
    return chartData;
  }

  Future<List<List>> loadLectures() async {
    List<List> response = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    User user = User.fromJson(jsonDecode(pref.getString("user")!));
    int? takenCourseId = user.id;

    http.Response? takenLectures = await rq.Request.getRequest(
      "https://eoeoservice.site/lecture/getlecturetaken",
      {"userId": "$takenCourseId"},
      true,
      true,
      context,
    );
    List takenLectureList =
    jsonDecode(utf8.decode(takenLectures!.bodyBytes));
    response.add(takenLectureList);

    return response;
  }
}

class BARData {
  BARData(this.mydata, this.ratio);
  final String mydata;
  final double ratio;
}



