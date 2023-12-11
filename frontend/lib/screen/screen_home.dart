import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/data/User.dart';
import 'package:frontend/widget/chartwidget.dart';
import 'package:frontend/widget/textwriter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen/show_user.dart';
import '../widget/barchart.dart';
import 'FAQ.dart';
import 'package:frontend/module/Request.dart' as rq;
import 'subject_taken.dart'; //기수강과목 불러오기
import 'main_major_course.dart'; //주전공 이수체계도 불러오기
import 'double_major_course.dart'; //주전공 이수체계도 불러오기

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences pref;
  bool isUserDataLoaded = false;

  // request module 사용하기 위해 필요한 함수
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((response) {
      pref = response;
      setState(() {
        isUserDataLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isUserDataLoaded) {
      return homeScreen();
    } else {
      return Container();
    }
  }

  Widget homeScreen() {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    User user = User.fromJson(jsonDecode(pref.getString("user")!));

    String name = user.name;
    String major = user.major;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("eoEo",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
          centerTitle: true,
          // Title을 가운데 정렬
          elevation: 1,
          // 그림자 조절
          leading: Container(),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0), // 오른쪽 패딩 추가
              child: IconButton(
                icon: Icon(
                  Icons.logout, // 로그 아웃 아이콘
                  color: Colors.black, // 아이콘 색상
                ),
                onPressed: () {
                  rq.Request.logout(context, pref);
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
            TextWriter(
                width: width,
                fontSize: 20,
                contents: "$name님은",
                textColor: Colors.black,
                fontWeight: FontWeight.bold),
            TextWriter(
                width: width,
                fontSize: 18,
                contents: "$major 전공입니다.",
                fontWeight: FontWeight.bold,
                textColor: Colors.black),
            Container(
              padding: EdgeInsets.only(bottom: width * 0.001),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // 가로로 동일한 간격으로 배치
                children: <Widget>[
                  ButtonTheme(
                    minWidth: width * 0.02,
                    height: height * 0.00125,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent),
                      ),
                      child: Text(
                        '주전공 강의정보',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      onPressed: () {
                        // 'Main_major_course' 페이지로 이동하는 코드
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainMajorCourse()),
                        );
                      },
                    ),
                  ),
                  ButtonTheme(
                    minWidth: width * 0.02,
                    height: height * 0.00125,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent),
                      ),
                      child: Text(
                        '복수전공 강의정보',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      onPressed: () {
                        // 'subject_takenScreen' 페이지로 이동하는 코드
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoubleMajorCourse()),
                        );
                        // 중앙 버튼을 눌렀을 때 수행할 작업을 여기에 추가
                      },
                    ),
                  ),
                  ButtonTheme(
                    minWidth: width * 0.02,
                    height: height * 0.00125,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent),
                      ),
                      child: Text(
                        '학업 현황',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      onPressed: () {
                        // 'subject_takenScreen' 페이지로 이동하는 코드
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Subject_takenScreen()),
                        ).then((response){
                          print("on pop working");
                          setState((){});
                        });
                        // 중앙 버튼을 눌렀을 때 수행할 작업을 여기에 추가
                      },
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(20.0), // 패딩 값은 필요에 따라 조절하세요
              child: Container(
                child: ChartWidget(title: ''),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
              children: <Widget>[
                Text(
                  '학업이수 달성도',
                  style: TextStyle(
                    fontSize: 23,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BarChartWidget(title: ''),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            // 바텀 버튼
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FAQScreen()));
                      },
                      child: Ink(
                        width: 80 * 0.7,
                        height: 30 * 0.7,
                        child: Image.asset(
                          "assets/images/FAQ.png", // 여기에 실제 이미지 파일 경로를 넣어주세요
                          height: 100.0 * 0.7, // 필요에 따라 높이 조절
                          width: 150 * 0.7,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowUser()));
                      },
                      child: Ink(
                        width: 100 * 0.7,
                        height: 30 * 0.7,
                        child: Image.asset(
                          "assets/images/USER.png", // 여기에 실제 이미지 파일 경로를 넣어주세요
                          height: 100.0 * 0.7, // 필요에 따라 높이 조절
                          width: 150 * 0.7,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
