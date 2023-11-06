import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/data/User.dart';
import 'package:frontend/module/Request.dart';
import 'package:frontend/screen/set.dart';
import 'package:frontend/widget/chartwidget.dart';
import 'package:frontend/widget/textwriter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../module/show_user.dart';
import '../widget/barchart.dart';
import 'FAQ.dart';
import 'login.dart';
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

  String testText ="";

  Widget? text;

  // request module 사용하기 위해 필요한 함수
  @override
  void initState(){
    SharedPreferences.getInstance().then((response){
      pref = response;
      setState(() {
        isUserDataLoaded = true;
      });
    });
  }


  Widget titleText(String test){
    return Text(
      //'Team eoEo',
      test,
      style: TextStyle(
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if(isUserDataLoaded){
      return homeScreen();
    } else{
      return Container();
    }

  }

  Widget homeScreen(){
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
          title: Text("eoEo", style: TextStyle(color: Colors.black)),
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
                  SharedPreferences.getInstance().then((response){
                    response.clear();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
                  });

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
            TextWriter(width:width, fontSize:20, contents: "$name님은", textColor: Colors.black, fontWeight: FontWeight.bold),
            TextWriter(width: width, fontSize: 18, contents:"$major 전공입니다.", fontWeight:FontWeight.bold, textColor: Colors.black),
            Container(
              padding: EdgeInsets.only(bottom: width * 0.001),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 가로로 동일한 간격으로 배치
                children: <Widget>[
                  ButtonTheme(
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
                        '주전공 이수체계도',
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
                          MaterialPageRoute(builder: (context) => MainMajorCourse()),
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
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                      ),
                      child: Text(
                        '복수전공 이수체계도',
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
                          MaterialPageRoute(builder: (context) => double_major_course()),
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
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
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
                          MaterialPageRoute(builder: (context) => Subject_takenScreen()),
                        );
                        // 중앙 버튼을 눌렀을 때 수행할 작업을 여기에 추가
                      },

                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container( // 차트 들어갈 공간
              child: ChartWidget(title: '',),
            ),
            /*
            Padding(
              padding: EdgeInsets.only(
                bottom: width * 0.00,
                top: width * 0.00,
                left: width * 0.00,
                right: width * 0.00,
              ),
            ),
             */
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
            Divider(),
          ],
        ),

        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            IconButton(
              icon: Icon(
                Icons.question_mark_rounded, // 검색 아이콘
                color: Colors.lightBlueAccent,
                size: 40,// 아이콘 색상
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FAQScreen()));
              },
            ),

            IconButton(
              icon: Icon(
                Icons.home_rounded, // 로그인 페이지 아이콘
                color: Colors.lightBlueAccent,
                size: 40,// 아이콘 색상
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),

            IconButton(
              icon: Icon(
                Icons.settings_rounded, // 환경설정 아이콘
                color: Colors.lightBlueAccent,
                size: 40,// 아이콘 색상
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShowUser()));
              },
            ),

          ],
        ),
      ),
    );
  }
}
