import 'package:flutter/material.dart';
import 'package:frontend/screen/set.dart';
import 'package:frontend/widget/chartwidget.dart';
import 'package:frontend/widget/textwriter.dart';
import '../widget/barchart.dart';
import 'FAQ.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.grey[900],
        backgroundColor: Colors.white,
        appBar: AppBar(
          //backgroundColor: Colors.grey[900],
          backgroundColor: Colors.white,
          title: Text(
            'Team eoEo',
            style: TextStyle(
              //color: Colors.white,
              color: Colors.black,
            ),
          ),
          centerTitle: true, // Title을 가운데 정렬
          elevation: 0.8, // 그림자 조절
          leading: Container(),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0), // 오른쪽 패딩 추가
              child: IconButton(
                icon: Icon(
                  Icons.search, // 검색 아이콘
                  color: Colors.black, // 아이콘 색상
                ),
                onPressed: () {
                  // 검색 버튼 클릭 시 수행할 동작 추가
                  /*
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => cont NextScreen())
          );

           */
                },
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10), // AppBar의 하단 모서리를 둥글게 설정
            ),
          ),
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextWriter(width:width, fontSize:20, contents: "윤영헌님은", textColor: Colors.black, fontWeight: FontWeight.bold),
            TextWriter(width: width, fontSize: 18, contents:"융합소프트웨어 전공입니다.", fontWeight:FontWeight.bold, textColor: Colors.black),
            Container(
              padding: EdgeInsets.only(bottom: width * 0.003),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // 오른쪽 정렬
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: width * 0.024), // 오른쪽 패딩 추가
                    child: ButtonTheme(
                      minWidth: width * 0.02,
                      height: height * 0.00125,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                        ),
                        child: Text(
                          '기수강 과목 확인',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container( // 차트 들어갈 공간
              child: ChartWidget(title: '',),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: width * 0.00,
                top: width * 0.00,
                left: width * 0.00,
                right: width * 0.00,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
              children: <Widget>[
                Text(
                  '학업이수 달성도',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                Icon(
                  Icons.local_fire_department_sharp,
                  color: Colors.pinkAccent,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: width * 0.00,
                top: width * 0.00,
                left: width * 0.00,
                right: width * 0.00,
              ),
            ),

            Center( // 차트 들어갈 공간
              child: BarChart(title: '',),
            ),

            Padding(
              padding: EdgeInsets.only(
                bottom: width * 0.024,
                top: width * 0.024,
                left: width * 0.024,
                right: width * 0.024,
              ),
            ),
            // 가로로 배치된 Elevated 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                  ),
                  onPressed: () {
                    // 버튼 1 클릭 시 수행할 동작
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FAQScreen()));
                  },
                  child: Text('FAQ'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                  ),
                  onPressed: () {
                    // 버튼 2 클릭 시 수행할 동작
                  },
                  child: Text('Home'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                  ),
                  onPressed: () {
                    // 버튼 3 클릭 시 수행할 동작
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                  },
                  child: Text('SET'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

