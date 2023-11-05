import 'package:flutter/material.dart';

class double_major_course extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          '복수전공 : 융합소프트웨어학과 이수체계도 보기',
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
                    title: Text('융합프로그래밍1'),
                    onTap: () {
                      // 융합프로그래밍1 과목에 대한 설명이 나오도록 할 수 있습니다.
                    },
                  ),
                  ListTile(
                    title: Text('컴퓨터시스템'),
                    onTap: () {
                      // 컴퓨터시스템 과목에 대한 설명이 나오도록 할 수 있습니다.
                    },
                  ),
                  ListTile(
                    title: Text('자료구조 및 알고리즘1'),
                    onTap: () {
                      // 자료구조 및 알고리즘1 과목에 대한 설명이 나오도록 할 수 있습니다.
                    },
                  ),
                  ListTile(
                    title: Text('융합프로그래밍2'),
                    onTap: () {
                      // 융합프로그래밍2 과목에 대한 설명이 나오도록 할 수 있습니다.
                    },
                  ),
                  ListTile(
                    title: Text('오픈소스소프트웨어프로젝트'),
                    onTap: () {
                      // 오픈소스소프트웨어프로젝트 과목에 대한 설명이 나오도록 할 수 있습니다.
                    },
                  ),
                  ListTile(
                    title: Text('융합캡스톤디자인'),
                    onTap: () {
                      // 융합캡스톤디자인 과목에 대한 설명이 나오도록 할 수 있습니다.
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
