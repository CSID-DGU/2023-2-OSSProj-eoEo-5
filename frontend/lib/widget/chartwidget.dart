import 'package:flutter/cupertino.dart';
import '../model/chartdata.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/chartdata.dart';

class ChartWidget extends StatefulWidget {
  ChartWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ChartWidget createState() => _ChartWidget();
}

class _ChartWidget extends State<ChartWidget> {
late List<data> _chartData;

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  // 리스트 데이터, DB에서 받야와야 함
  List<data> getChartData(){
    final List<data> chartData = [
      data('major', 50),
      data('double major', 30),
      data('liberal arts', 33),
    ];

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            width: 370,
            height: 370,
            child: SfCircularChart(
              series: <CircularSeries>[
                RadialBarSeries<data, String>(
                    dataSource: _chartData,
                    xValueMapper: (data data, _) => data.section,
                    yValueMapper: (data data, _) => data.credit,
                    pointColorMapper: (data data, _) {
                      if (data.section == "major") {
                        return Colors.lightBlue;
                    } else if (data.section == "double major") {
                        return Colors.greenAccent;
                    } else if (data.section == "liberal arts") {
                        return Colors.yellowAccent;
                    }
                  },
                    maximumValue: 90

                    )
              ],
            )));
  }
}
