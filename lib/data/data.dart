import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hizliflutter/models/main_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_string.dart';
import 'api.dart';
import 'package:http/http.dart' as http;

enum DataType {
  Widget,
  News,
  Question,
  Sample,
  Post,
  Comment,
  User,
  Login,
  Register,
  Logout,
}

class Data extends Api {
  static Future<List> get({
    @required bool isSecure,
    @required DataType dataType,
    int id,
  }) async {
    String endUrl = '';
    switch (dataType) {
      case DataType.Widget:
        endUrl = id != null ? 'widget/$id' : 'widgets';
        break;
      case DataType.News:
        endUrl = id != null ? 'news/$id' : 'news';
        break;
      case DataType.Post:
        endUrl = id != null ? 'post/$id' : 'posts';
        break;
      case DataType.Comment:
        endUrl = id != null ? 'comment/$id' : 'comments';
        break;
      case DataType.Question:
        endUrl = id != null ? 'question/$id' : 'questions';
        break;
      case DataType.Sample:
        endUrl = id != null ? 'sample/$id' : 'samples';
        break;
      case DataType.User:
        endUrl = id != null ? 'user/$id' : 'users';
        break;
    }
    try {
      final http.Response response = await http
          .get(Uri.parse(AppString.webUrl + AppString.webDataUrl + endUrl));

      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body);
        return parsedJson;
      } else {
        print('Get Error: ' + dataType.toString());
        return null;
      }
    } on TimeoutException catch (_) {
      print('Get Timeout: ' + dataType.toString());
    }
  }

  static Future<http.Response> post({
    @required DataType dataType,
    MainModel body,
    @required bool isSecure,
    @required bool isToken,
  }) async {
    String endUrl = '';
    switch (dataType) {
      case DataType.Widget:
        endUrl = 'widget';
        break;
      case DataType.News:
        endUrl = 'news';
        break;
      case DataType.Post:
        endUrl = 'post';
        break;
      case DataType.Comment:
        endUrl = 'comment';
        break;
      case DataType.Question:
        endUrl = 'question';
        break;
      case DataType.Sample:
        endUrl = 'sample';
        break;
      case DataType.User:
        endUrl = 'user';
        break;
      case DataType.Login:
        endUrl = 'login';
        break;
      case DataType.Register:
        endUrl = 'register';
        break;
      case DataType.Logout:
        endUrl = 'logout';
        break;
    }
    try {
      var token;
      if(isToken){
        SharedPreferences preferences = await SharedPreferences.getInstance();
        if (preferences.containsKey('user') &&
            preferences.containsKey('userLoginToken')) {
          token = await preferences.getString('userLoginToken');
        }
      }
      http.Response response = await http.post(
          Uri.parse(AppString.webUrl + AppString.webDataUrl + endUrl),
          body: body != null ? jsonEncode(body.toJson()) : jsonEncode(''),
          headers: isToken&&token!=null
              ? {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer ' + token,
                }
              : AppString.header);

      return response;
    } on TimeoutException catch (_) {
      print('Post Timeout: ' + dataType.toString());
    }
  }

  @override
  Future update() {}

  @override
  Future delete() {}

  @override
  Future put() {}
}
