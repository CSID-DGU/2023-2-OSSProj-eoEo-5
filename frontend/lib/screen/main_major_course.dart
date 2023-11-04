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
            //fontWeight: FontWeight.bold,
          ),),
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

            ListTile(
              title: Text('필수과목1'), //들은 학점도 오른쪽 상단에 나오면 좋겠다
              onTap: () {
              },
            ),
            ListTile(
              title: Text('필수과목2'), //들은 학점도 오른쪽 상단에 나오면 좋겠다
              onTap: () {
              },
            ),
        ListTile(
          title: Text('선택과목1'), //들은 학점도 오른쪽 상단에 나오면 좋겠다
          onTap: () {
          },
        ),
          ],
        ),
      ),
    );
  }
}

