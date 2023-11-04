import 'dart:convert';

import 'package:frontend/screen/login.dart';
import 'package:frontend/screen/screen_home.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

import '../module/user_model.dart';
import 'package:http/http.dart' as http;

// 서버로 데이터를 보내는 서비스
Future<void> saveUser(User user) async { // 비동기 처리로 진행
  try {
    final response = await http.post(
      Uri.parse(""), // 서버 연결: 서버주소
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, // HTTP 메시지를 JSON 형식으로 변환하여 전송하기 위한 헤더 설정
      body: jsonEncode(user.toJson()), // User 객체를 JSON 문자열로 인코딩하여 요청 본문으로 설정
    );
    if (response.statusCode != 201) { // HTTP 응답 상태 코드가 201(Created)가 아닌 경우
      throw Exception("Failed to send data");
    } else {
      print("User Data sent successfully");
      Get.to(LoginScreen()); // 데이터 보내고 어디로 이동해야 할지
    }
  } catch (e) {
    print("Failed to send post data: ${e}");
  }
}
// HTTP 모듈에서 요청 보낼 때, 헤더 값에 jwt값을 넣어야 함. var
// shared preference 웹형태로 로컬에 저장하는(회원가입 데이터 임시저장)