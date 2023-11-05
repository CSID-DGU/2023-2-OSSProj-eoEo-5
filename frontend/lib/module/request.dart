import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

// delete, post 요청
// 토큰 값이 있어면 토큰 값 자동적으로 심어서 보내주는 코드
// 엑세스 토큰이 없으면 리프레쉬 토큰(재발급), 토큰 값을 다시 POST, 실패하면 로그아웃
// 실제 토큰 처리 로직

String? accessToken; // 현재 엑세스 토큰
String? refreshToken; // 리프레시 토큰

// getWithoutAuthWithParameter: 인증 없이 parameter만 사용하여 GET 요청
Future<Map<String, dynamic>?> getWithoutAuthWithParameter(String url, Map<String, dynamic> data) async{
  Map<String,String> headers = { // Content-Type 헤더를 application/json으로 설정
    "Content-Type" : "application/json"
  };

  url = url + "?"; // URL 초기화

  for(int i = 0; i<data.length; i++){ // 반복문을 통해 쿼리 문자열 생성
    String key = data.keys.elementAt(i);
    String value = data.values.elementAt(i);

    String queryString = "$key=$value";
    url = url + queryString;

    if(i != data.length-1){ // 마지막 매개변수가 아닌 경우 앰퍼샌드 추가
      url = url + "&";
    }
  }

  var response = await http.get(Uri.parse(url)); // GET 요청을 수행

  return handleResponse(response);
}

// getWithoutAuth 인증 없이 GET 요청
Future<Map<String, dynamic>?> getWithoutAuth(String url) async{

  var response = await http.get(Uri.parse(url));

  return handleResponse(response);

}

//postWithoutAuthWithBody: 인증없이 BODY를 사용하여 POST 요청을 수행
Future<Map<String, dynamic>?> postWithoutAuthWithBody(String url, Map<String, dynamic> data) async {
  Map<String,String> headers = {
    "Content-Type" : "application/json"
  };

  var response = await http.post(Uri.parse(url),
      headers: headers,
      body: jsonEncode(data)); // BODY를 사용하여 POST 요청을 수행

  return handleResponse(response);
}

// postWithoutAuthWithParameter: 인증 없이 매개변수를 사용하여 POST 요청 수행
Future<Map<String, dynamic>?> postWithoutAuthWithParameter(String url, Map<String, dynamic> data) async{
  Map<String,String> headers = {
    "Content-Type" : "application/json"
  };

  url = url + "?"; // URL 초기화

  for(int i = 0; i<data.length; i++){
    String key = data.keys.elementAt(i);
    String value = data.values.elementAt(i);

    String queryString = "$key=$value";
    url = url + queryString;

    if(i != data.length-1){
      url = url + "&";
    }
  }

  var response = await http.post(Uri.parse(url));

  return handleResponse(response);
}

// postWithoutAuth: 인증 없이 POST 요청을 수행하는 함수
Future<Map<String, dynamic>?> postWithoutAuth(String url) async{

  var response = await http.post(Uri.parse(url));

  return handleResponse(response);

}

// handleResponse: HTTP 응답을 처리하& JSON 데이터를 디코딩
Map<String, dynamic>? handleResponse(http.Response response){
  final responseBody = utf8.decode(response.bodyBytes); // 응답 본문을 디코딩
  final json = jsonDecode(responseBody); // JSON 파싱
  return json; // 파싱된 JSON 데이터 반환
}