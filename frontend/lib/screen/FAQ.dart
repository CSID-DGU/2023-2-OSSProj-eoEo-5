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
              title: Text('FAQ1'),
              subtitle: Text('답변'),
              onTap: () {
              },
            ),
            ListTile(
              title: Text('FAQ2'),
              subtitle: Text('답변'),
              onTap: () {
              },
            ),
            ListTile(
              title: Text('FAQ2'),
              subtitle: Text('답변'),
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
