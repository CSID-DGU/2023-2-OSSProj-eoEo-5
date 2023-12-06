import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/data/User.dart';
import 'package:frontend/module/Request.dart';
import 'package:frontend/screen/register.dart';
import 'package:frontend/screen/screen_home.dart';
import 'package:frontend/widget/textwritercenter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LogInState();
}

class _LogInState extends State<LoginScreen> {
  late SharedPreferences pref;

  // text field와 연결
  TextEditingController controller = TextEditingController(); // ID
  TextEditingController controller2 = TextEditingController(); // PW

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: 10)),
          // 원하는 이미지 파일을 사용하여 Image 위젯 추가
          Image.asset(
            'assets/images/login_logo_ rmbg.png', // 여기에 실제 이미지 파일 경로를 넣어주세요
            height: 100.0, // 필요에 따라 높이 조절
            width: 100,
            fit: BoxFit.cover,
          ),
          TextWritercenter(width: 20, fontSize: 20, contents: "융합소프트웨어를 더 현명하게", textColor: Colors.grey, fontWeight: FontWeight.w600),
          TextWritercenter(width: 20, fontSize: 28, contents: "모두의 융소", textColor: Colors.lightBlue, fontWeight: FontWeight.w900),
          Padding(padding: EdgeInsets.only(top: 0.5)), // 이미지 아래에 약간의 여백 추가
          Form(
              child: Theme(
            data: ThemeData(
                primaryColor: Colors.grey,
                inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.teal, fontSize: 15.0))),
            child: Container(
                padding: EdgeInsets.all(10.0),
                // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
                // SingleChildScrollView으로 감싸 줌
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: 300,
                        height:45.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: 'ID',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                            border: InputBorder.none, // Remove internal TextField border
                          ),
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey, // 텍스트의 색상을 회색으로 변경
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0,), // Add some spacing between the text fields
                      Container(
                        width: 300,
                        height:45.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: TextField(
                          controller: controller2,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'PASSWARD',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                            ),
                            border: InputBorder.none, // Remove internal TextField border
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          style: TextStyle(
                            color: Colors.grey, // 텍스트의 색상을 회색으로 변경
                          ),
                        ),
                      ),
                      SizedBox(height: 0.5), // Add some spacing before the button
                      Container(
                        width: 300, // Make the width match the parent
                        child: ButtonTheme(
                          // Set the minWidth to match the parent's width
                          height: 50.0,
                          child: ElevatedButton(
                            onPressed: () {
                              login(controller.text, controller2.text).then((response) {
                                if (response) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => HomeScreen(),
                                    ),
                                        (Route<dynamic> route) => false,
                                  );
                                } else {
                                  showSnackBar(context, Text('Check your info again'));
                                }
                              });
                            },
                            child: Text(
                              '로그인',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(height: 1.0), // Adjust spacing before the Register button
                      TextButton(
                        child: Text("회원가입", style: TextStyle(color: Colors.black, fontSize: 17,fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => Registerpage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )),
          ))
        ],
      ),
    );
  }

  Future<bool> login(String username, String password) async {
    Map<String, String> loginData = {
      "username": username,
      "password": password
    };

    http.Response? responseData = await Request.postRequestWithBody(
        "https://eoeoservice.site/auth/login", loginData, false, context);

    Map<String, dynamic>? response = Request.handleResponseMap(responseData!);

    if (response!.containsKey('id')) {
      pref = await SharedPreferences.getInstance();
      User user = User(response);
      await pref.setString('user', jsonEncode(user));
      await pref.setString('accessToken', response['accessToken']);
      await pref.setString('refreshToken', response['refreshToken']);
      return true;
    } else {
      return false;
    }
  }
}

void showSnackBar(BuildContext context, Text text) {
  final snackBar = SnackBar(
    content: text,
    backgroundColor: Color.fromARGB(255, 112, 50, 50),
  );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
