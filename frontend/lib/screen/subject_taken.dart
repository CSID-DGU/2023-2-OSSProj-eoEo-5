import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/data/User.dart';
import 'package:frontend/module/Request.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Subject_takenScreen extends StatefulWidget {
  @override
  _Subject_takenScreen createState() => _Subject_takenScreen();// 상태 클래스 반환
}

/*
1. 서버에서 response응답을 받아옴
2. lectureList에 response 저장
3. renderWidgets 메서드에 response
 */

class _Subject_takenScreen extends State<Subject_takenScreen> {
  // Subject_takenScreen 위젯의 상태 클래스
  bool isDataLoaded = false; // 데이터가 로드되었는지 여부를 나타내는 플래그
  List<Widget> takenLectureWidgets = []; // 컨테이너에 띄울 리스트 위젯
  late List<List> lectureList; // 리스트를 담을 리스트

  @override
  void initState() { // 초기화 메서드
    
    super.initState();
    loadLectures().then((response) { // 강의 정보를 불러오는 비동기 함수 호출
      lectureList = response; // 불러온 강의 정보를 lectureList에 저장
      renderWidgets(response); // 강의 정보를 위젯으로 렌더링
      setState(() {
        isDataLoaded = true; // 데이터가 로드되었음을 표시
      });
    });

  }

  @override
  Widget build(BuildContext context) { // 위젯 빌드 메서드
    if (isDataLoaded) {
      return renderScreen();
    } else {
      return Container();
    }
  }

  Widget renderScreen() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("taken subject", style: TextStyle(color: Colors.white,fontSize: 25 , fontWeight: FontWeight.bold)),
          centerTitle: true, // Title을 가운데 정렬
          elevation: 0.8, // 그림자 조절
          leading: Container(),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0), // 오른쪽 패딩 추가
              child: IconButton(
                icon: Icon(
                  Icons.add_box_outlined, // 추가 아이콘
                  color: Colors.white, // 아이콘 색상
                ),
                onPressed: () {showadd();},
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10), // AppBar의 하단 모서리를 둥글게 설정
            ),
          ),
        ),
        body: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Text("기수강 과목", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Column(
                children: takenLectureWidgets,
              )
            ]
          )
        )
    );
  }

  Future<List<List>> loadLectures() async { // 강의 정보를 불러오는 비동기 함수
    List<List> response = []; // 응답 데이터를 담을 2차원 리스트
    SharedPreferences pref = await SharedPreferences.getInstance(); // SharedPreferences 인스턴스 생성
    User user = User.fromJson(jsonDecode(pref.getString("user")!)); // 사용자 정보
    int? takenCourseId = user.id; // 사용자의 기수강 ID

    http.Response? takenLectures = await Request.getRequest( // 서버에 강의 정보 요청
        "https://eoeoservice.site/lecture/getlecturetaken",
        {"userId": "$takenCourseId"}, // 기수강 ID를 파라미터로 전달
        true,
        true,
        context);

    List takenLectureList = jsonDecode(utf8.decode(takenLectures!.bodyBytes)); // 응답데이터 디코딩

    response.add(takenLectureList);

    return response;
  }

  void renderWidgets(List<List> lectures) {// 리스트를 위젯으로 렌더링하는 메소드
    takenLectureWidgets = [];

    for (int i = 0; i < lectures[0].length; i++) { // 리스트 테이블
      takenLectureWidgets.add(
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  lectures[0][i]['name'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
            ],
          )
      );
    }
  }


  void showadd() {
    bool? ismajor;
    bool? issecond;
    bool? iscore;
    bool? issub;

    showDialog<String>(
      context: context,
      // 다이얼로그 배경을 터치했을 때 다이얼로그를 닫을지 말지 결정
      // true = 닫을 수 있음, false = 닫을 수 없음
      barrierDismissible: true,

      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.grey.shade100,
            shadowColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            // z축 높이, elevation의 값이 높을 수록 그림자가 아래 위치하게 됩니다.
            elevation: 10,

            // 다이얼로그의 위치 설정, 기본값은 center
            alignment: Alignment.bottomCenter,
            /*
          Dialog의 padding 값입니다..
          sizedBox의 가로세로 값읠 infinity로 설정해놓고
          가로패딩 50, 세로 패딩 200을 줬습니다.
          이렇게 하면 좌우 50, 위아래 200만큼의 패딩이 생기고 배경이 나오게 됩니다.
          여기서 vertical의 값을 많이 주면,
          키보드가 올라왔을 때 공간이 부족해서 overflow가 발생할 수 있습니다.
           */
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 100,
            ),
            // 소프트키보드가 올라왔을 때 다이얼로그의 사이즈가 조절되는 시간
            insetAnimationDuration: const Duration(milliseconds: 1000),

            // 소프트키보드가 올라왔을 때 다이얼로그 사이즈 변경 애니메이션
            insetAnimationCurve: Curves.bounceOut,

            child: SizedBox(
                width: 100,
                height: 200,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "내가 들은 과목 추가",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: "학수번호를 입력해주세요 !",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 40,
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13),), value: ismajor ?? false, onChanged: (value){setState(() {ismajor=value;});}),
                          Text("전공", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),),
                          Checkbox(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)), value: issecond ?? false, onChanged: (value){setState(() {issecond=value;});}),
                          Text("복수전공", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),),
                          Checkbox(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)), value: iscore ?? false, onChanged: (value){setState(() {iscore=value;});}),
                          Text("교양", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 20,
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),), value: issub ?? false, onChanged: (value){setState(() {issub=value;});}),
                          Text("대체 과목 여부", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 5,
                    ),

                    SizedBox(
                      width: 60,
                      height: 30,
                      child: ElevatedButton(

                          onPressed: () {
                            // Navigator.pop에서 result값을 넣어주면
                            // showDialog의 return 값이 됩니다.
                            print("Confirmed"); // test
                            Navigator.pop(context, "return value");
                          },
                          child: const Text("확인")),
                    ),
                  ],
                )),
          );
        }
        );
      },
    ).then((value) {
      /// Navigator.pop 의 return 값이 들어옵니다.
    }).whenComplete(() {
      /// 다이얼로그가 종료됐을 때 호출됩니다.
    });
  }
}



// 이름입력하면 학수번호 조회
// 주전공인지, 복수전공인지, 교양인지
// 대체과목인지

/*
addLectureValue = {
  "accountId": accountId, // string
  "isCoreLecture": isCoreLecture, // bool
  "isSecondMajor": isSecondMajor, // bool
  "isSubstitute": isSubstitute, // bool
  "lectureNumber": lectureNumber, // string
  "originalLectureNumber": originalLectureNumber, // string
  }
*/
