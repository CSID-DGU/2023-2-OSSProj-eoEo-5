import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/module/Request.dart';
/*
import 'package:member/global.dart';
import 'package:member/pages/login/login.page.dart';
*/

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  _RegisterpageState createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController userNameTextController = TextEditingController(); // ID
  TextEditingController passwordTextController = TextEditingController(); // PW
  TextEditingController nameTextController = TextEditingController(); // ID
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
    Request.getRequest("https://eoeoservice.site/auth/majorlist", {}, false,
            false, context)
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
              }),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Username", style: TextStyle(fontSize: 20)),
                  TextField(
                    controller: userNameTextController,
                    keyboardType: TextInputType.text,
                  ),
                  const Text("Password", style: TextStyle(fontSize: 20)),
                  TextField(
                    controller: passwordTextController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                  const Text("Name", style: TextStyle(fontSize: 20)),
                  TextField(
                    controller: nameTextController,
                    keyboardType: TextInputType.text
                  ),
                  const Text("Major", style: TextStyle(fontSize: 20)),
                  DropdownButton(
                      value: selectedMajor,
                      items: majorItemList.map((value) {
                        return DropdownMenuItem(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedMajor = value.toString();
                        });
                      }),
                  const Text("SecondMajor", style: TextStyle(fontSize: 20)),
                  TextButton(
                    child: isThereSecondMajor
                        ? Text("복수전공 선택 헤제")
                        : Text("복수전공 선택"),
                    onPressed: () {
                      setState(() {
                        isThereSecondMajor = !isThereSecondMajor;
                      });
                    },
                  ),
                  Container(
                    child: isThereSecondMajor ? DropdownButton(
                        value: selectedSecondMajor,
                        items: majorItemList.map((value) {
                          return DropdownMenuItem(
                              value: value, child: Text(value));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSecondMajor = value.toString();
                          });
                        })
                        : Container()
                  ),
                  TextButton(child: Text("Register"), onPressed: () {
                    Map<String, dynamic> registerValue;
                    String username = userNameTextController.text;
                    String password = passwordTextController.text;
                    String name = nameTextController.text;
                    int majorId = majorList[majorItemList.indexOf(selectedMajor)]['majorId'];
                    if(isThereSecondMajor){
                      int secondMajorId = majorList[majorItemList.indexOf(selectedSecondMajor)]['majorId'];
                      print(secondMajorId);
                      registerValue = {
                        "username" : username,
                        "password" : password,
                        "name" : name,
                        "majorId" : majorId,
                        "isSecondMajor" : true,
                        "secondMajorId" : secondMajorId
                      };
                    } else{
                      registerValue = {
                        "username" : username,
                        "password" : password,
                        "name" : name,
                        "majorId" : majorId,
                        "isSecondMajor" : false
                      };
                    }
                    Request.postRequestWithBody("https://eoeoservice.site/auth/register", registerValue, false, context).then((response){
                      if(response?.statusCode == 200){
                        Navigator.pop(context);
                      }else{
                        setState((){
                          titleText = "다시 시도해주세요";
                        });
                      }
                    });

                  })
                ])));
  }
}
