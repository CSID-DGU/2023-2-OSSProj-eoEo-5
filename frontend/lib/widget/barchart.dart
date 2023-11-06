import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    _chartData = getChartData();

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
                      return Colors.lightBlueAccent;
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

  List<BARData> getChartData() {
    final List<BARData> chartData = [
      BARData('달성도', 70),
    ];
    return chartData;
  }
}

class BARData {
  BARData(this.mydata, this.ratio);
  final String mydata;
  final double ratio;
}
