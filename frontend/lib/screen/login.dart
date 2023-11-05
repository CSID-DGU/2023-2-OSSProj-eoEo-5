import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/data/User.dart';
import 'package:frontend/screen/screen_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../module/request.dart';

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
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
        elevation: 0.0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {
            // ID/PW 찾기
          })
        ],
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 50)),
          Form(
              child: Theme(
                data: ThemeData(
                    primaryColor: Colors.grey,
                    inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(color: Colors.teal, fontSize: 15.0))),
                child: Container(
                    padding: EdgeInsets.all(40.0),
                    // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
                    // SingleChildScrollView으로 감싸 줌
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            controller: controller,
                            decoration: InputDecoration(labelText: 'Enter ID'),
                            keyboardType: TextInputType.text,
                          ),
                          TextField(
                            controller: controller2,
                            decoration:
                            InputDecoration(labelText: 'Enter password'),
                            keyboardType: TextInputType.text,
                            obscureText: true, // 비밀번호 안보이도록 하는 것
                          ),
                          SizedBox(height: 40.0,),
                          ButtonTheme(
                              minWidth: 100.0,
                              height: 50.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  login(controller.text, controller2.text).then((response){
                                    if(response){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) => HomeScreen()
                                          )
                                      );
                                    }else{
                                      showSnackBar(context, Text('Check your info again'));
                                    }
                                  });

                                },
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue,
                                ),
                              )
                          )
                        ],
                      ),
                    )),
              ))
        ],
      ),
    );
  }

  Future<bool> login(String username, String password) async{
    Map<String, String> loginData = {
      "username" : username,
      "password" : password
    };

    Map<String, dynamic>? response = await postWithoutAuthWithBody("https://eoeoservice.site/auth/login", loginData);

    if(response!.containsKey('id')){
      pref = await SharedPreferences.getInstance();
      User user = User(response);
      await pref.setString('user', jsonEncode(user));
      return true;
    } else{
      return false;
    }
  }
}

void showSnackBar(BuildContext context, Text text) {
  final snackBar = SnackBar(
    content: text,
    backgroundColor: Color.fromARGB(255, 112, 48, 48),
  );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

