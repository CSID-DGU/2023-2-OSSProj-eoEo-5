import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          'FAQ',
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
              '소프트웨어 교육원 FAQ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Divider(), // 구분선 추가

            ListTile(
              title: Text('여기다가'),
              subtitle: Text('이제 크롤링한 데이터를'),
              onTap: () {
              },
            ),
            ListTile(
              title: Text('붙이며는'),
              subtitle: Text('됩니다아'),
              onTap: () {
              },
            ),
            ListTile(
              title: Text('하이구'),
              subtitle: Text('힘드롱'),
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
