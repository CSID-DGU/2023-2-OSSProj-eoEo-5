import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          'FAQ',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                  ),
                  onPressed: () {
                    _navigateToFAQPage(context, '지원');
                  },
                  child: Text(
                    '지원',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                  ),
                  onPressed: () {
                    _navigateToFAQPage(context, '교과');
                  },
                  child: Text(
                    '교과',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                  ),
                  onPressed: () {
                    _navigateToFAQPage(context, '학점인정');
                  },
                  child: Text(
                    '학점인정',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16), // 필요에 따라 간격 조절

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                  ),
                  onPressed: () {
                    _navigateToFAQPage(context, '졸업');
                  },
                  child: Text(
                    '졸업',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                  ),
                  onPressed: () {
                    _navigateToFAQPage(context, '취업');
                  },
                  child: Text(
                    '취업',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16), // 필요에 따라 간격 조절
          ],
        ),
      ),
    );
  }

  void _navigateToFAQPage(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FAQCategoryScreen(category)),
    );
  }
}

class FAQCategoryScreen extends StatelessWidget {
  final String category;

  FAQCategoryScreen(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category FAQ'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('$category FAQ1'),
            subtitle: Text('$category에 관한 자주 묻는 질문에 대한 답변'),
            onTap: () {
              // FAQ1을 눌렀을 때 처리할 로직 작성
            },
          ),
          ListTile(
            title: Text('$category FAQ2'),
            subtitle: Text('$category에 관한 자주 묻는 질문에 대한 답변'),
            onTap: () {
              // FAQ2를 눌렀을 때 처리할 로직 작성
            },
          ),
          // 다른 FAQ 항목들도 유사한 방식으로 추가할 수 있습니다.
        ],
      ),
    );
  }
}
