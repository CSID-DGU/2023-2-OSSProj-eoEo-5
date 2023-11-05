import 'package:flutter/material.dart';

class Main_major_course extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          '주전공 : 경영학과 이수체계도 보기',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '전공필수',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Divider(), // 구분선 추가

            // ListView를 사용하여 스크롤 가능한 목록 생성
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('경영학원론'),
                    onTap: () {
                      // 경영학원론에 대한 설명이 나오도록 할 수 있습니다.
                    },
                  ),
                  ListTile(
                    title: Text('조직행위'),
                    onTap: () {
                      // 조직행위 과목에 대한 설명이 나오도록 할 수 있습니다.
                    },
                  ),
                  ListTile(
                    title: Text('재무관리'),
                    onTap: () {
                      // 재무관리 과목에 대한 설명이 나오도록 할 수 있습니다.
                    },
                  ),
                  // 다른 과목 항목들도 유사하게 추가할 수 있습니다.
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
