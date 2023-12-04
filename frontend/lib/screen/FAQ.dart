import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  String selectedCategory = '지원'; // 초기 선택 카테고리

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
                    MaterialStateProperty.all<Color>(
                        selectedCategory == '지원'
                            ? Colors.blue
                            : Colors.lightBlueAccent),
                  ),
                  onPressed: () {
                    changeCategory('지원');
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
                    MaterialStateProperty.all<Color>(
                        selectedCategory == '교과'
                            ? Colors.blue
                            : Colors.lightBlueAccent),
                  ),
                  onPressed: () {
                    changeCategory('교과');
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
                    MaterialStateProperty.all<Color>(
                        selectedCategory == '학점인정'
                            ? Colors.blue
                            : Colors.lightBlueAccent),
                  ),
                  onPressed: () {
                    changeCategory('학점인정');
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
                    MaterialStateProperty.all<Color>(
                        selectedCategory == '졸업'
                            ? Colors.blue
                            : Colors.lightBlueAccent),
                  ),
                  onPressed: () {
                    changeCategory('졸업');
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
                    MaterialStateProperty.all<Color>(
                        selectedCategory == '취업'
                            ? Colors.blue
                            : Colors.lightBlueAccent),
                  ),
                  onPressed: () {
                    changeCategory('취업');
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

            // FAQ 항목 출력
            ListTile(
              title: Text('$selectedCategory FAQ1'),
              subtitle: Text('$selectedCategory에 관한 자주 묻는 질문에 대한 답변'),
              onTap: () {
                // FAQ1을 눌렀을 때 처리할 로직 작성
              },
            ),
            ListTile(
              title: Text('$selectedCategory FAQ2'),
              subtitle: Text('$selectedCategory에 관한 자주 묻는 질문에 대한 답변'),
              onTap: () {
                // FAQ2를 눌렀을 때 처리할 로직 작성
              },
            ),
          ],
        ),
      ),
    );
  }

  void changeCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }
}
