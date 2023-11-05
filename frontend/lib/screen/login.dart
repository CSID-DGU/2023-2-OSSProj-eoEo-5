import 'package:flutter/material.dart';
import 'package:frontend/screen/screen_home.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LogInState();
}

class _LogInState extends State<LoginScreen> {

  // text field와 연결
  TextEditingController controller = TextEditingController(); // ID
  TextEditingController controller2 = TextEditingController(); // PW

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
                                onPressed: (){
                                  if (controller.text == 'admin' &&
                                      controller2.text == '1234') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                NextPage(HomeScreen())
                                        )
                                    );
                                  }
                                  else if (controller.text == 'admin' && controller2.text != '1234') {
                                    showSnackBar(context, Text('Wrong password'));
                                  }
                                  else if (controller.text != 'admin' && controller2.text == '1234') {
                                    showSnackBar(context, Text('Wrong email'));
                                  }
                                  else {
                                    showSnackBar(context, Text('Check your info again'));
                                  }

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

class NextPage extends StatelessWidget {
  const NextPage(homeScreen, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}