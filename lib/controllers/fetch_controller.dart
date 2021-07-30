import 'dart:convert';

import 'package:get/get.dart';
import 'package:hizliflutter/app_string.dart';
import 'package:hizliflutter/models/news.dart';
import 'package:hizliflutter/models/widget_model.dart';
import 'package:http/http.dart' as http;

class FetchController extends GetxController {
  List<WidgetModel> widgetListe = List<WidgetModel>().obs;
  List<News> haberListe = List<News>().obs;
/*
  Future<void> getWidgets() async {
    widgetListe.clear();
    final Firestore _firestore = Firestore.instance;
    QuerySnapshot querySnapshot =
        await _firestore.collection("widgetler").getDocuments();
    for (int i = 0; i < querySnapshot.documents.length; i++) {
      widgetListe.add(WidgetModel.fromJson(querySnapshot.documents[i].data));
    }
    update();
  }*/

/*
  Future<void> getNews() async {
    haberListe.clear();
    final Firestore _firestore = Firestore.instance;
    QuerySnapshot querySnapshot =
        await _firestore.collection("haberler").getDocuments();
    for (int i = 0; i < querySnapshot.documents.length; i++) {
      haberListe.add(News.fromJson(querySnapshot.documents[i].data));
    }
    for (int i = 0; i < haberListe.length; i++) {
      haberListe.sort((a, b) {
        return a.releaseDate.compareTo(b.releaseDate);
      });
    }
    haberListe = haberListe.reversed.toList();
    update();
  }*/

  Future<void> getNewsApi() async {
    haberListe.clear();
    final http.Response response =
        await http.get(AppString.webUrl + AppString.webDataUrl + 'news');

    if (response.statusCode == 200) {
      var parsedJson = jsonDecode(response.body);
      for (var model in parsedJson) {
        haberListe.add(News.fromJson(model));
      }
    } else {
      print('Hata var:' + response.body);
    }
    update();
  }

  Future<void> getWidgetsApi() async {
    widgetListe.clear();
    final http.Response response = await http
        .get(AppString.webUrl + AppString.webDataUrl + 'widgets');

    if (response.statusCode == 200) {
      var parsedJson = jsonDecode(response.body);
      for (var model in parsedJson) {
        widgetListe.add(WidgetModel.fromJson(model));
      }
    } else {
      print('Hata var');
    }
    update();
  }
}
