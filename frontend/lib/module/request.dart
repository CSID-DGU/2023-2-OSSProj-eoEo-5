import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

// delete, post 요청
// 토큰 값이 있어면 토큰 값 자동적으로 심어서 보내주는 코드
// 엑세스 토큰이 없으면 리프레쉬 토큰(재발급), 토큰 값을 다시 POST, 실패하면 로그아웃

// 실제 토큰 처리 로직
String? accessToken; // 현재 엑세스 토큰
String? refreshToken; // 리프레시 토큰

// GET
Future<String?> getData(String url) async {
  var response = await http.get(Uri.parse(url));
  return _handleResponse(response);
}

// POST
Future<String?> postData(String url, Map<String, dynamic> data) async {
  final headers = <String, String>{
    'Content-Type': 'application/json',
  };

  // 엑세스 토큰이 있으면 요청 헤더에 추가
  if (accessToken != null){
    headers['Authorization']='Bearer $accessToken';
  }

  final body = jsonEncode(data);

  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: body,
  );

  // 토큰 재발급
  final newAccessToken = _handleResponse(response);
  if (newAccessToken != null){
    accessToken = newAccessToken;
    return newAccessToken;
  }
  else{
    // 로그아웃
    return null;
  }
}

// HTTP 응답을 처리하고 새로운 액세스 토큰을 반환하는 함수
String? _handleResponse(http.Response response) {
  final statusCode = response.statusCode;
  final responseBody = utf8.decode(response.bodyBytes);

  if (statusCode == 200) {
    final json = jsonDecode(responseBody);
    if (json.containsKey('access_token')) {
      return json['access_token'];
    }
  }
  return null; // 새로운 액세스 토큰을 찾을 수 없음
}
