import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          '환경 설정',
          style: TextStyle(
            color: Colors.white,
            //fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '일반 설정',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text('푸시 알림 설정'),
              trailing: Switch(
                value: true, // 푸시 알림 설정 상태를 표시
                onChanged: (bool value) {
                  // 푸시 알림 설정 변경 핸들러
                  // 여기에 설정을 저장하거나 업데이트하는 로직을 추가할 수 있습니다.
                },
              ),
            ),
            Divider(), // 구분선 추가

            Text(
              '사용자 정보',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text('사용자 이름'),
              subtitle: Text('윤영헌'), // 사용자 이름 표시
              onTap: () {
                // 사용자 이름 설정 페이지로 이동하거나 수정 가능한 대화상자 표시
              },
            ),
            ListTile(
              title: Text('학번'),
              subtitle: Text('2019111383'), // 이메일 주소 표시
              onTap: () {
                // 이메일 주소 설정 페이지로 이동하거나 수정 가능한 대화상자 표시
              },
            ),
            ListTile(
              title: Text('전공'),
              subtitle: Text('경영학과 / 융합소프트웨어'), // 이메일 주소 표시
              onTap: () {
                // 이메일 주소 설정 페이지로 이동하거나 수정 가능한 대화상자 표시
              },
            ),
          ],
        ),
      ),
    );
  }
}
