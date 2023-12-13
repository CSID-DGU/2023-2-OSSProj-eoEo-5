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
  late List<List> lectureList; // 강의 리스트를 담을 리스트
  TextEditingController addtec = TextEditingController();
  TextEditingController substituteTextFieldController = TextEditingController();
  TextEditingController deletetec = TextEditingController();

  // checkbox
  bool? ismajor = false;
  bool? issecond = false;
  bool? iscore = false;
  bool? issub = false;
  bool? isExist = false;
  bool isAddDataLoad = false;
  bool isDeleteDataLoad = false;
  String? addlectureName;
  String? deletelectureName;

  @override
  void initState() {
    // 초기화 메서드
    super.initState();
    loadLectures().then((response) { // 강의 정보를 불러오는 비동기 함수 호출
      lectureList = response; // 불러온 강의 정보를 lectureList에 저장
      renderWidgets(response); // 강의 정보를 위젯으로 렌더링
      setState(() {
        isDataLoaded = true; // 데이터가 로드되었음을 표시
      });
    });
  }

  void refresh(){
    Future.delayed(const Duration(milliseconds: 1000), () {
      loadLectures().then((response) { // 강의 정보를 불러오는 비동기 함수 호출
        lectureList = response; // 불러온 강의 정보를 lectureList에 저장
        renderWidgets(response); // 강의 정보를 위젯으로 렌더링
        setState(() {
          isDataLoaded = true; // 데이터가 로드되었음을 표시
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    // 위젯 빌드 메서드
    if (isDataLoaded) {
      return renderScreen();
    } else {
      return Container();
    }
  }

  Widget renderScreen() {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "taken subject",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0.8,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.add_box_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  showadd();
                },
              ),
            ),
            SizedBox(width: 0),
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.delete_outline_sharp,
                  color: Colors.white,
                ),
                onPressed: () {
                  delete();
                },
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
    ),

    body: Container(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Text("기수강 과목",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Column(
                    children: takenLectureWidgets,
                  )
                ]
                )
            ),
        )
    );
  }

  Future<List<List>> loadLectures() async {
    // 강의 정보를 불러오는 비동기 함수
    List<List> response = []; // 응답 데이터를 담을 2차원 리스트
    SharedPreferences pref = await SharedPreferences
        .getInstance(); // SharedPreferences 인스턴스 생성
    User user = User.fromJson(jsonDecode(pref.getString("user")!)); // 사용자 정보
    int? takenCourseId = user.id; // 사용자의 기수강 ID

    http.Response? takenLectures = await Request.getRequest( // 서버에 강의 정보 요청
        "https://eoeoservice.site/lecture/getlecturetaken",
        {"userId": "$takenCourseId"}, // 기수강 ID를 파라미터로 전달
        true,
        true,
        context);

    List takenLectureList = jsonDecode(
        utf8.decode(takenLectures!.bodyBytes)); // 응답데이터 디코딩

    response.add(takenLectureList);

    return response;
  }

  void renderWidgets(List<List> lectures) {
    // 리스트를 위젯으로 렌더링하는 메소드
    takenLectureWidgets = [];

    for (int i = 0; i < lectures[0].length; i++) { // 리스트 테이블
      takenLectureWidgets.add(
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Text(
                  lectures[0][i]['name'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10,)
            ],
          )
      );
    }
  }

  // 삭제 기능 메서드
  void delete(){
    Map<String, dynamic> deleteData = {};
    deletetec = TextEditingController();
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
                      "내가 수강한 과목 삭제",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight
                          .bold),
                    ),
                    TextField(
                      controller: deletetec,
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
                      height: 30,
                    ),

                    SizedBox(
                      width: 60,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () async {
                            // 사용자 추가 데이터 불러오기: (비동기)
                            var deleteValue = await loadDeleteLecture(deletetec.text);
                            deleteData = deleteValue;
                            // 데이터 로드
                            setState(() {
                              isDeleteDataLoad = true;
                              }
                            );
                            print(isDeleteDataLoad); // test log: false이면 데이터를 못 가져옴
                            // 데이터가 로딩되면, delete api요청
                            if (isDeleteDataLoad){
                              try{
                                // 리스트에서 삭제하는 코드 작성
                                // 로컬에서 들고 있는 강의 정보 중에서 강의 이름 찾기
                                for(int i=0; i<lectureList[0].length; i++){
                                  if(lectureList[0][i]["lectureNumber"] == deleteData["lectureNumber"]){
                                    deletelectureName = lectureList[0][i]["name"];
                                  }
                                }
                                // 들고 있는 리스트에서의 해당 과목의 리스트 찾기
                                int cnt = 0;
                                for(int i=0; i<lectureList[0].length; i++){
                                  if(lectureList[0][i]["name"] == deletelectureName){
                                    break;
                                  }
                                  cnt ++;
                                }
                                print(deletelectureName); // 삭제 데이터 잘 들고 옴
                                Request.deleteRequest(
                                    "https://eoeoservice.site/lecture/deletetakenlecture", deleteData, true, true, context
                                ).then((response) {
                                  if (response?.statusCode == 200) {
                                    lectureList[0].removeAt(cnt); // 데이터 삭제
                                    takenLectureWidgets.removeAt(cnt); // 위젯 삭제
                                    Navigator.pop(context);
                                    refresh();
                                  } else {
                                    setState(() {});
                                  }
                                });
                              } catch(error){
                                print("Error occurred: $error");
                              }
                            }
                            // log test
                            print("Confirmed");
                            print(deleteData);
                            },
                          child: const Text("확인")
                      ),
                    ),
                  ],
                )
              ),
            );
          }
        );
      },
    ).then((value) {
      // Navigator.pop 의 return 값이 들어옵니다.
    }).whenComplete(() {});
  }

  // 추가 기능 메서드
  void showadd() {
    addtec = TextEditingController();
    substituteTextFieldController = TextEditingController();
    Map<String, dynamic> addData = {};

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
                width: 300,
                height: 250,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "내가 들은 과목 추가",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight
                          .bold),
                    ),
                    TextField(
                      controller: addtec,
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
                          Checkbox(shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),),
                              value: ismajor ?? false,
                              onChanged: (value) {
                                setState(() {
                                  ismajor = value;
                                });
                              }),
                          Text("전공", style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 13),),
                          Checkbox(shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
                              value: issecond ?? false,
                              onChanged: (value) {
                                setState(() {
                                  issecond = value;
                                });
                              }),
                          Text("복수전공", style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 13),),
                          Checkbox(shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
                              value: iscore ?? false,
                              onChanged: (value) {
                                setState(() {
                                  iscore = value;
                                });
                              }),
                          Text("교양", style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 13),),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 20,
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),),
                              value: issub ?? false,
                              onChanged: (value) {
                                setState(() {
                                  issub = value;
                                });
                              }),
                          Text("대체 과목 여부", style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 13),),
                        ],
                      ),
                    ),

                    // 새로운 텍스트 필드 추가
                    if (issub == true)
                      TextField(
                        controller: substituteTextFieldController, // 새로 추가한 텍스트 필드의 컨트롤러
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "대체과목의 학수번호를 입력해주세요 !",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),

                    SizedBox(
                      height: 8,
                    ),

                    SizedBox(
                      width: 60,
                      height: 30,
                      child: ElevatedButton(
                          onPressed: () async {
                            // 사용자 추가 데이터 불러오기: (비동기)
                            var addValue = await loadAddLecture(addtec.text, substituteTextFieldController.text);
                            addData = addValue;
                            // 데이터 로드
                            setState(() {
                              isAddDataLoad = true;
                            });
                            // test log
                            print(isAddDataLoad); // false이면 데이터를 못 가져옴
                            // 데이터가 로딩되면, post api요청
                            if (isAddDataLoad){
                              try{
                                Request.postRequestWithBody(
                                    "https://eoeoservice.site/lecture/addlecturetaken", addData, true, context
                                ).then((response) {
                                  if (response?.statusCode == 200) {
                                    Map<String, dynamic> responseData = jsonDecode(utf8.decode(response?.bodyBytes as List<int>));
                                    addlectureName = responseData["lectureName"];
                                    print(addlectureName); // 새로 추가한 과목의 이름

                                    // 리스트 위젯에 추가
                                    // add 중복확인 // 처음 입력시 false, 두번째 입력시 ture
                                    for(int i=0; i<lectureList[0].length; i++){
                                      if(lectureList[0][i]["name"] == addlectureName){
                                        isExist = true;
                                        break;
                                      }
                                    }
                                    if(!isExist!){
                                      lectureList[0].add({"name":addlectureName, "lectureNumber": addtec.text});
                                      takenLectureWidgets.add(
                                          Column(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(8.0),
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  addlectureName!,
                                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          )
                                      );
                                    }
                                    isExist = false;
                                    Navigator.pop(context);
                                    setState(() {});
                                    refresh();
                                  } else if(response?.statusCode != 200){
                                    setState((){});
                                  }
                                });
                              } catch(error){
                                print("Error occurred: $error");
                              }
                            }
                            // log test
                            print("Confirmed");
                            print(issub);
                            print(ismajor);
                            print(issecond);
                            print(iscore);
                            print(addData);
                          },
                          child: const Text("확인")
                      ),
                    ),
                  ],
                )
              ),
            );
          }
        );
      },
    ).then((value) {
      // Navigator.pop 의 return 값이 들어옵니다.
    }).whenComplete(() {});
  }

  Future<Map<String, dynamic>> loadDeleteLecture(String lectureNumber) async {
    Map<String, dynamic>? deletevalue = {};
    SharedPreferences? pref = await SharedPreferences.getInstance(); // SharedPreferences 인스턴스 생성
    User user = User.fromJson(jsonDecode(pref?.getString("user") ?? "{}")!); // 사용자 정보
    int? accountId = user.id;

    // api 파라미터
    deletevalue = {
      "lectureNumber":lectureNumber,
      "userId":"$accountId"
    };

    return deletevalue;
  }


  // post요청에 보낼 json데이터: user값을 불러와야해서 비동기로 처리
  Future<Map<String, dynamic>> loadAddLecture(String lectureNumber, String originalLectureNumber) async {
    Map<String, dynamic>? addvalue = {};

    SharedPreferences? pref = await SharedPreferences.getInstance(); // SharedPreferences 인스턴스 생성
    User user = User.fromJson(jsonDecode(pref?.getString("user") ?? "{}")!); // 사용자 정보
    int? accountId = user.id;

    // 잘목된 체크 값일 경우 null 값 반환
    if (issub! == false) {
      if (ismajor! && !issecond! && !iscore!) {
        addvalue = {
          "accountId": accountId, // int
          "isCoreLecture": false, // bool
          "isSecondMajor": false, // bool
          "isSubstitute": false, // bool
          "lectureNumber": lectureNumber, // string
        };
      }
      else if (issecond! && !ismajor! && !iscore!) {
        addvalue = {
          "accountId": accountId, // int
          "isCoreLecture": false, // bool
          "isSecondMajor": true, // bool
          "isSubstitute": false, // bool
          "lectureNumber": lectureNumber, // string
        };
      }
      else if (iscore! && !ismajor! && !issecond!) {
        addvalue = {
          "accountId": accountId, // int
          "isCoreLecture": true, // bool
          "isSecondMajor": false, // bool
          "isSubstitute": false, // bool
          "lectureNumber": lectureNumber, // string
        };
      }
      else{
        addvalue = {};
      }
    }
    else if (issub!) { // ismajor, issecond, issub
      if (ismajor! && !issecond! && !iscore!) {
        addvalue = {
          "accountId": accountId, // int
          "isCoreLecture": false, // bool
          "isSecondMajor": false, // bool
          "isSubstitute": false, // bool
          "lectureNumber": lectureNumber, // string
          "originalLectureNumber": originalLectureNumber, // string
        };
      }
      else if (issecond! && !ismajor! && !iscore!) {
        addvalue = {
          "accountId": accountId, // int
          "isCoreLecture": false, // bool
          "isSecondMajor": true, // bool
          "isSubstitute": true, // bool
          "lectureNumber": lectureNumber, // string
          "originalLectureNumber": originalLectureNumber, // string
        };
      }
      else if (iscore! && !ismajor! && !issecond!) {
        addvalue = {
          "accountId": accountId, // int
          "isCoreLecture": true, // bool
          "isSecondMajor": false, // bool
          "isSubstitute": true, // bool
          "lectureNumber": lectureNumber, // string
          "originalLectureNumber": originalLectureNumber, // string
        };
      }
      else{
        addvalue = {};
      }
    };
    return addvalue;
  }

}