import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hizliflutter/models/main_model.dart';

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
}

class Data extends Api {
  @override
  Future<List<MainModel>> get({
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
      final http.Response response =
          await http.get(Uri.parse(AppString.webUrl + AppString.webDataUrl + endUrl));

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

  @override
  Future<bool> post({
    @required bool isSecure,
    @required String url,
    var body,
    String header,
  }) {}

  @override
  Future update() {}

  @override
  Future delete() {}

  @override
  Future put() {}
}
