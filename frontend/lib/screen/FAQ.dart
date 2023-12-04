
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

  @override
  void initState(){ // 초기화 메서드

    super.initState();
    SharedPreferences.getInstance().then((response){
      pref = response;
      loadFaq().then((response){
        setState(() {
          isFaqDataLoaded = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) { // build method

    if(isFaqDataLoaded){
      return faqScreen();
    } else{
      return Container();
    }

  }

  Widget faqScreen(){ // rendering screen
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextWriter(width: width, fontSize: 18, contents:"FAQ", fontWeight:FontWeight.bold, textColor: Colors.black),
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
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                        ),
                        child: Text(
                          'support',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: () {},
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
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                        ),
                        child: Text(
                          'subject',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: () {},
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
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                        ),
                        child: Text(
                          'job',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: () {},
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
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                        ),
                        child: Text(
                          'credit',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),ButtonTheme(
                      minWidth: width * 0.02,
                      height: height * 0.00125,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                        ),
                        child: Text(
                          'etc',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: Row(

          ),

        )
    );
  }

  Future<Map<String ,List>> loadFaq() async{
    SharedPreferences pref = await SharedPreferences
        .getInstance(); // SharedPreferences 인스턴스 생성
    User user = User.fromJson(jsonDecode(pref.getString("user")!)); // 사용자 정보
    int? userId = user.id;
    Map<String, List> faqs = {};

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
    // faq {A:[{a:b}, {a:b}], B:[{a:b}, {a:b}]}

    return faqs;
  }
/*
  1 버튼은 supportList, subjectList, jobList, creditList, etcList
    faq map에서 버튼 하나씩 빼감
   */


}
