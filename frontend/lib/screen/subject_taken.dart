import 'package:flutter/material.dart';

class Subject_takenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          '학업 현황',
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
              '내가 들은 과목',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Divider(), // 구분선 추가

            ListTile(
              title: Text('2018년도'),
              subtitle: Text('들은 과목이 리스트로 나와요~ '), //들은 학점도 오른쪽 상단에 나오면 좋겠다
              onTap: () {
              },
            ),
            ListTile(
              title: Text('2019년도'),
              subtitle: Text('들은 과목이 리스트로 나와요~ '),
              onTap: () {
              },
            ),
            ListTile(
              title: Text('2023년도'),
              subtitle: Text('들은 과목이 리스트로 나와요~'), // 휴학을 짱 오래했다는 설정과 지금 듣고있는 년도도 볼 수 잇음
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}

