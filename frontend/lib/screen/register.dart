import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/module/Request.dart' as rq;

import '../widget/textwritercenter.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  _RegisterpageState createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  bool isMajorListDataLoaded = false;
  bool isThereSecondMajor = false;
  int majorId = 0;
  int secondMajorId = 0;
  List majorItemList = [];
  String titleText = "Register";

  late String selectedMajor;
  late String selectedSecondMajor;
  late List majorList;

  @override
  void initState() {
    super.initState();
    rq.Request.getRequest("https://eoeoservice.site/auth/majorlist", {}, false, false, context)
        .then((response){
      majorList = jsonDecode(utf8.decode(response!.bodyBytes));
      for (int i = 0; i < majorList.length; i++) {
        majorItemList.add(majorList[i]['name']);
      }
      selectedMajor = majorItemList[0];
      selectedSecondMajor = majorItemList[0];
      setState(() {
        isMajorListDataLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isMajorListDataLoaded) {
      return renderRegisterScreen();
    } else {
      return Container();
    }
  }

  Widget renderRegisterScreen() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(titleText),
        elevation: 0.0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            TextWritercenter(width: 20, fontSize: 20, contents: "환영합니다", textColor: Colors.black54, fontWeight: FontWeight.w600),
            const SizedBox(height: 3),
            TextWritercenter(width: 20, fontSize: 20, contents: "모두의 융소입니다!", textColor: Colors.black54, fontWeight: FontWeight.w600),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(right: 260.0), // 원하는 만큼의 왼쪽 여백을 지정하세요.
              child: const Text("아이디", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ),
            Container(
              height: 30,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20), // 수정된 부분
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: TextField(
                controller: userNameTextController,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700), // 폰트 크기 수정
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  //hintText: '사용할 아이디',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(right: 250.0), // 원하는 만큼의 왼쪽 여백을 지정하세요.
              child: const Text("비밀번호", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ),
            Container(
              height: 30,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20), // 수정된 부분
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: TextField(
                controller: passwordTextController,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700), // 폰트 크기 수정
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  //hintText: '사용할 비밀번호',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(right: 240.0), // 원하는 만큼의 왼쪽 여백을 지정하세요.
              child: const Text("사용할 이름", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),),
            ),
            Container(
              height: 30,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20), // 수정된 부분
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: TextField(
                controller: nameTextController,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700), // 폰트 크기 수정
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  //hintText: '사용할 닉네임을 입력해주세요.',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(right: 260.0), // 원하는 만큼의 왼쪽 여백을 지정하세요.
              child: const Text("주전공", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ),
            Container(
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: DropdownButton(
                padding: EdgeInsets.symmetric(horizontal: 10),
                value: selectedMajor,
                items: majorItemList.map((value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMajor = value.toString();
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: isThereSecondMajor
                  ? Icon(Icons.remove)  // 선택 해제 상태에서는 제거 아이콘
                  : Icon(Icons.add),     // 선택 상태에서는 추가 아이콘
              label: Text(
                isThereSecondMajor
                    ? "복수전공 선택 해제"
                    : "복수전공 선택",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700), // 원하는 폰트 크기로 설정
              ),
              onPressed: () {
                setState(() {
                  isThereSecondMajor = !isThereSecondMajor;
                });
              },
            ),
            // SecondMajor Dropdown (Conditional)
            if (isThereSecondMajor)
              Container(
                height: 30,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: DropdownButton(
                  value: selectedSecondMajor,
                  items: majorItemList.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSecondMajor = value.toString();
                    });
                  },
                ),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: Text("Register"),
              onPressed: () {
                Map<String, dynamic> registerValue;
                String username = userNameTextController.text;
                String password = passwordTextController.text;
                String name = nameTextController.text;
                int majorId =
                majorList[majorItemList.indexOf(selectedMajor)]['majorId'];
                if (isThereSecondMajor) {
                  int secondMajorId = majorList[majorItemList
                      .indexOf(selectedSecondMajor)]['majorId'];
                  print(secondMajorId);
                  registerValue = {
                    "username": username,
                    "password": password,
                    "name": name,
                    "majorId": majorId,
                    "isSecondMajor": true,
                    "secondMajorId": secondMajorId
                  };
                } else {
                  registerValue = {
                    "username": username,
                    "password": password,
                    "name": name,
                    "majorId": majorId,
                    "isSecondMajor": false
                  };
                }
                rq.Request.postRequestWithBody(
                    "https://eoeoservice.site/auth/register",
                    registerValue,
                    false,
                    context)
                    .then((response) {
                  if (response?.statusCode == 200) {
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      titleText = "다시 시도해주세요";
                    });
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
