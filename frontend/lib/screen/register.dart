import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/module/Request.dart' as rq;

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
        .then((response) {
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
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1), // 수정된 부분
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Username", style: TextStyle(fontSize: 20)),
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
                style: TextStyle(fontSize: 15), // 폰트 크기 수정
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: '사용할 아이디',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Password", style: TextStyle(fontSize: 20)),
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
                style: TextStyle(fontSize: 15), // 폰트 크기 수정
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: '사용할 비밀번호',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Name", style: TextStyle(fontSize: 20)),
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
                style: TextStyle(fontSize: 15), // 폰트 크기 수정
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: '사용할 닉네임을 입력해주세요.',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Major", style: TextStyle(fontSize: 20)),
            Container(
              height: 30,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20), //
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: DropdownButton(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
            const Text("SecondMajor", style: TextStyle(fontSize: 20)),
            TextButton(
              child: isThereSecondMajor
                  ? Text("복수전공 선택 해제")
                  : Text("복수전공 선택"),
              onPressed: () {
                setState(() {
                  isThereSecondMajor = !isThereSecondMajor;
                });
              },
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
              child: isThereSecondMajor
                  ? DropdownButton(
                value: selectedSecondMajor,
                items: majorItemList.map((value) {
                  return DropdownMenuItem(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSecondMajor = value.toString();
                  });
                },
              )
                  : Container(),
            ),
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
