import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/module/Request.dart' as rq;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/User.dart';

class FAQScreen extends StatefulWidget{

  @override
  _FAQScreenSate createState() => _FAQScreenSate();
}

class _FAQScreenSate extends State<FAQScreen>{

  late SharedPreferences pref;
  bool isFaqDataLoaded = false;

  List<Widget> faqWidgets = []; // 전공선택 강의 위젯 목록

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
          appBar: AppBar(

          ),
          body: Column(
            children: faqWidgets,

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
    int? faqId = user.id;

    Map<String, List> faqs = {};

    // FAQ api 요청
    http.Response? faq = await rq.Request.getRequest(
      "https://eoeoservice.site/faq/getfaq",
        {"userId": "$faqId"},
      true,
      true,
      context);

    Map<String, dynamic> faqList = jsonDecode(utf8.decode(faq!.bodyBytes));
    print(faqList);
    //faqs.add(faqList);

    return faqs;
  }

  void renderWidgets(List<List> faqs){
    print(faqs);
    faqWidgets=[];
    for(int i=0; i< faqs.length; i++){
      faqWidgets.add(
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              child: Text(
                faqs[i][0],
              ),
            )
          ],
        )
      );
    }
  }


}
