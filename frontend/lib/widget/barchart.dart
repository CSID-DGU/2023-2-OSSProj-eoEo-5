import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/User.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/module/Request.dart' as rq;
import 'package:fl_chart/fl_chart.dart';
import 'package:vertical_barchart/extension/expandedSection.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';


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
        height: 60,
        child: barchart(datatrans(getChartData(chartData)))
      ),
    );
  }

  // 전처리한 데이터를 리스트에 맞는 데이터로 변환
  List<VBarChartModel> datatrans(List<BARData> getChartData){
    List<VBarChartModel> bardata = [];
    double data = getChartData[0].ratio;
    return(
        bardata = [
        VBarChartModel(
        index: 0,
        label: "",
          colors: [Color(0xff00FFFF), Color(0xff00FFFF)],
          jumlah: data, // 실 수치
          tooltip: "${data}",  // 수치 레이블

        ),
      ]
    );
  }

  Widget barchart(List<VBarChartModel> datatrans) {
    return VerticalBarchart(
      background: Colors.transparent,
      legendPosition: LegendPosition.TOP,
      tooltipColor: Color(0xff8e97a0),
      maxX: 100,
      data: datatrans,
      barSize: 20,
      barStyle: BarStyle.DEFAULT,
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



