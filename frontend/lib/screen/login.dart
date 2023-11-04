import 'package:flutter/material.dart';
import 'package:frontend/screen/set.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Scaffold(
      // 부모 위젯를 Scaffold로 변경
      appBar: AppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(
              Icons.question_mark_rounded,
              color: Colors.lightBlueAccent,
              size: 40,
            ),
            onPressed: () {
              // 버튼 클릭 시 동작을 추가할 수 있습니다.
            },
          ),
          IconButton(
            icon: Icon(
              Icons.home_rounded,
              color: Colors.lightBlueAccent,
              size: 40,
            ),
            onPressed: () {
              // 버튼 클릭 시 동작을 추가할 수 있습니다.
            },
          ),
          IconButton(
            icon: Icon(
              Icons.settings_rounded,
              color: Colors.lightBlueAccent,
              size: 40,
            ),
            onPressed: () {
              // 버튼 클릭 시 동작을 추가할 수 있습니다.
            },
          ),
        ],
      ),
    );
  }
}
