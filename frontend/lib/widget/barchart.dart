import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late List<BARData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          width: 350,
          height: 80,
          child: Align(
            alignment: Alignment.centerLeft, // 왼쪽 정렬을 위해 Alignment.centerLeft 사용
            child: SfCartesianChart(
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
              primaryXAxis: CategoryAxis(),
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