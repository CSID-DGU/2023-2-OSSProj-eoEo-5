import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../screen/login.dart';

class Request{

  static Future<http.Response?> getRequest(String url, Map<String, dynamic> data, bool isAuthRequired, bool isThereParameter, BuildContext context) async {
    Map<String, String> headers = {
      "Content-Type" : "application/json",
      "Accept" : "application/json"
    };

    if(isAuthRequired){
      SharedPreferences pref = await SharedPreferences.getInstance();
      String accessToken = pref.containsKey("accessToken") ? pref.getString("accessToken")! : " ";
      Map<String, String> authToken = {"Authorization" : accessToken};
      headers.addAll(authToken);
    }

    if(isThereParameter){
      url = url + "?";

      for(int i = 0; i<data.length; i++){
        String key = data.keys.elementAt(i);
        String value = data[key];

        url = url + "$key=$value";

        if(i != data.length-1){
          url = url = "&";
        }
      }
    }

    var response = await http.get(Uri.parse(url), headers: headers);

    if(response.statusCode == 200){
      return response;
    } else if(isAuthRequired){
      return getWithRefreshToken(url, data, isThereParameter, context);
    } else{
      SharedPreferences pref = await SharedPreferences.getInstance();
      logout(context, pref);
      return null;
    }
  }

  static Future<http.Response?> postRequestWithBody(String url, Map<String, dynamic> data, bool isAuthRequired, BuildContext context) async {
    Map<String, String> headers = {
      "Content-Type" : "application/json",
      "Accept" : "application/json"
    };

    if(isAuthRequired){
      SharedPreferences pref = await SharedPreferences.getInstance();
      String accessToken = pref.containsKey("accessToken") ? pref.getString("accessToken")! : " ";
      Map<String, String> authToken = {"Authorization" : accessToken};
      headers.addAll(authToken);
    }

    var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(data));

    if(response.statusCode == 200){
      return response;
    } else if(isAuthRequired){
      return postWithRefreshTokenWithBody(url, data, context);
    } else{
      SharedPreferences pref = await SharedPreferences.getInstance();
      logout(context, pref);
      return null;
    }
  }

  static Future<http.Response?> getWithRefreshToken(String url, Map<String, dynamic> data , bool isThereParameter, BuildContext context) async{

    print("Refresh");

    SharedPreferences pref = await SharedPreferences.getInstance();
    if(!pref.containsKey("refreshToken")){
      logout(context, pref);
      return null;
    }

    Map<String, String> tokenRequestHeader = {
      "Content-Type" : "application/json",
      "Accept" : "application/json"
    };

    Map<String, String> refreshTokenData = {"refreshToken" : pref.getString("refreshToken")!};

    var tokenRefreshResponse = await http.post(Uri.parse("https://eoeoservice.site/auth/newtoken"), headers: tokenRequestHeader, body: jsonEncode(refreshTokenData));

    var newTokenData = handleResponseMap(tokenRefreshResponse);

    if(tokenRefreshResponse.statusCode != 200 || newTokenData!["validated"] == false){
      logout(context, pref);
      return null;
    }

    pref.setString("accessToken", newTokenData["accessToken"]);
    pref.setString("refreshToken", newTokenData["refreshToken"]);

    Map<String, String> headers = {
      "Content-Type" : "application/json",
      "Accept" : "application/json",
      "Authorization" : "Bearer ${pref.getString("accessToken")}"
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if(response.statusCode != 200){
      logout(context, pref);
      return null;
    }

    return response;
  }

  static Future<http.Response?> postWithRefreshTokenWithBody(String url, Map<String, dynamic> data, BuildContext context) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(!pref.containsKey("refreshToken")){
      logout(context, pref);
      return null;
    }

    Map<String, String> tokenRequestHeader = {
      "Content-Type" : "application/json",
      "Accept" : "application/json"
    };

    Map<String, String> refreshTokenData = {"refreshToken" : pref.getString("refreshToken")!};

    var tokenRefreshResponse = await http.post(Uri.parse("https://eoeoservice.site/auth/newtoken"), headers: tokenRequestHeader, body: jsonEncode(refreshTokenData));

    var newTokenData = handleResponseMap(tokenRefreshResponse);

    if(tokenRefreshResponse.statusCode != 200 || newTokenData!['validation'] == false){
      logout(context, pref);
      return null;
    }

    pref.setString("accessToken", newTokenData["accessToken"]);
    pref.setString("refreshToken", newTokenData["refreshToken"]);

    Map<String, String> headers = {
      "Content-Type" : "application/json",
      "Accept" : "application/json",
      "Authorization" : "Bearer ${pref.getString("accessToken")}"
    };

    var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(data));

    if(response.statusCode != 200){
      logout(context, pref);
      return null;
    }

    return response;
  }

  static Map<String, dynamic>? handleResponseMap(http.Response response){
    final responseBody = utf8.decode(response.bodyBytes); // 응답 본문을 디코딩
    final json = jsonDecode(responseBody); // JSON 파싱
    return json; // 파싱된 JSON 데이터 반환
  }

  static void logout(BuildContext context, SharedPreferences pref){
    pref.clear();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
  }

}