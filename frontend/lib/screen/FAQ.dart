import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/module/Request.dart' as rq;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/User.dart';
import '../widget/textwriter.dart';

class FAQScreen extends StatefulWidget{
  @override
  _FAQScreenSate createState() => _FAQScreenSate();
}

class _FAQScreenSate extends State<FAQScreen>{
  late SharedPreferences pref;
  bool isFaqDataLoaded = false;
  late Map<String, dynamic> faqData = {}; // FQA 데이터 저장
  String selectedCategory = "supportList"; // 선택할 카테고리

  @override
  void initState() {
    super.initState();
    // loadFaq 함수에서 데이터를 가져옴
    loadFaq().then((response) {
      setState(() {
        isFaqDataLoaded = true;
        faqData = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) { // build method

    if(faqData == null){ // faq데이터가 null값일 경우 데이터 로드중 표시
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    else if(isFaqDataLoaded){
      return faqScreen();
    } else{
      return Container();
    }
  }

  void updateAndLoadFAQ(String category) async {
    setState(() {
      selectedCategory = category;
      isFaqDataLoaded = false; // 새로운 카테고리를 선택하면 데이터를 다시 로딩
    });

    // loadFaq 함수에서 데이터를 가져옴
    await loadFaq().then((response) {
      setState(() {
        isFaqDataLoaded = true;
        faqData = response;
      });
    });
  }

  Widget faqScreen(){ // rendering screen
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: TextWriter(width: width, fontSize: 18, contents:"FAQ", fontWeight:FontWeight.bold, textColor: Colors.white),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: width * 0.001),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 가로로 동일한 간격으로 배치
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: width * 0.02,
                      height: height * 0.00125,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            selectedCategory == "supportList"
                                ? Colors.blue // 선택된 카테고리는 다르게 표시
                                : Colors.lightBlueAccent,
                          ),
                        ),
                        child: Text(
                          'support',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: () {
                          updateAndLoadFAQ("supportList");
                          },
                      ),
                    ),
                    ButtonTheme(
                      minWidth: width * 0.02,
                      height: height * 0.00125,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            selectedCategory == "subjectList"
                                ? Colors.blue // 선택된 카테고리는 다르게 표시
                                : Colors.lightBlueAccent,
                          ),
                        ),
                        child: Text(
                          'subject',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: (){
                          updateAndLoadFAQ("subjectList");
                        },
                      ),
                    ),
                    ButtonTheme(
                      minWidth: width * 0.02,
                      height: height * 0.00125,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            selectedCategory == "jobList"
                                ? Colors.blue // 선택된 카테고리는 다르게 표시
                                : Colors.lightBlueAccent,
                          ),
                        ),
                        child: Text(
                          'job',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: (){
                          updateAndLoadFAQ("jobList");
                        },
                      ),
                    ),
                    ButtonTheme(
                      minWidth: width * 0.02,
                      height: height * 0.00125,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            selectedCategory == "creditList"
                                ? Colors.blue // 선택된 카테고리는 다르게 표시
                                : Colors.lightBlueAccent,
                          ),
                        ),
                        child: Text(
                          'credit',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: () {
                          updateAndLoadFAQ("creditList");
                        },
                      ),
                    ),ButtonTheme(
                      minWidth: width * 0.02,
                      height: height * 0.00125,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            selectedCategory == "etcList"
                                ? Colors.blue // 선택된 카테고리는 다르게 표시
                                : Colors.lightBlueAccent,
                          ),
                        ),
                        child: Text(
                          'etc',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: () {
                          updateAndLoadFAQ("etcList");
                        },
                      ),
                    ),
                  ],
                ),
              ),
             Expanded(child: FAQList(faqData[selectedCategory] ?? [])),
            ],
          ),
        )
    );
  }

  // 비동기로 faq데이터를 받아오는 메서드: <String, dynamic>
  Future<Map<String ,dynamic>> loadFaq() async{
    SharedPreferences pref = await SharedPreferences
        .getInstance(); // SharedPreferences 인스턴스 생성
    User user = User.fromJson(jsonDecode(pref.getString("user")!)); // 사용자 정보
    int? userId = user.id;

    // FAQ api 요청
    http.Response? faq = await rq.Request.getRequest(
        "https://eoeoservice.site/faq/getfaq",
        {"userId": "$userId"},
        true,
        true,
        context);

    // map 형식으로 faq 데이터를 받아옴
    Map<String, dynamic> faqdata = jsonDecode(utf8.decode(faq!.bodyBytes));
    // test
    print(faqdata);
    print(faqdata["supportList"]);
    // faqdata {A:[{a:b}, {a:b}], B:[{a:b}, {a:b}]}

    return faqdata;
  }
}

class FAQList extends StatelessWidget {
  final List<dynamic> faqmap;

  FAQList(this.faqmap); //생성자

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: faqmap.length,
      itemBuilder: (context, index) {
        final item = faqmap[index];
        return FAQItem(
          question: item['question']!,
          answer: item['answer']!,
        );
      },
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Q: $question',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('A: $answer'),
          ],
        ),
      ),
    );
  }
}



