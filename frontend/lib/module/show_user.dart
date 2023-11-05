import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/module/request.dart';
import 'package:frontend/module/user_model.dart';

class ShowUser extends StatefulWidget {
  const ShowUser({Key? key}) : super(key: key);

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  late final String url = "";
  Future<User>? user;

  @override
  void initState() {
    super.initState();
    //user = getData(url) as Future<User>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('USER', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<User>(
            //통신데이터 가져오기
            future: user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return buildColumn(snapshot);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}에러!!");
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }

  Widget buildColumn(snapshot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('이름:' + snapshot.data!.id.toString(),
            style: TextStyle(fontSize: 20)),
        Text('전공:' + snapshot.data!.userName.toString(),
            style: TextStyle(fontSize: 20)),
        Text('복수전공:' + snapshot.data!.account.toString(),
            style: TextStyle(fontSize: 20)),
        Text('학년:' + snapshot.data!.balance.toString(),
            style: TextStyle(fontSize: 20)),
      ],
    );
  }
}