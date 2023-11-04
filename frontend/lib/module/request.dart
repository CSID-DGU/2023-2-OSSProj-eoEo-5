import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

// delete, post 요청
// 토큰 값이 있어면 토큰 값 자동적으로 심어서 보내주는 코드
// 엑세스 토큰이 없으면 리프레쉬 토큰(재발급), 토큰 값을 다시 POST, 실패하면 로그아웃

Future<List> fetchData(String url) async {
  var response = await http.get(url as Uri); // GET 요청
  var statusCode = response.statusCode; // HTTP 응답 상태 코드 가져옴
  var responseHeaders = response.headers; // HTTP 응답 헤더 가져옴
  String responseBody = utf8.decode(response.bodyBytes); // HTTP 응답 본문을 디코딩하여 문자열로 저장

  List<dynamic> list = jsonDecode(responseBody); // JSON 문자열 파싱, 동적 데이터로 저장

  return list;
}
