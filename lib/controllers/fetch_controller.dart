import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/models/news.dart';
import 'package:hizliflutter/models/widget_model.dart';

class FetchController extends GetxController {
  List<WidgetModel> widgetListe = List<WidgetModel>().obs;
  List<News> haberListe = List<News>();

  Future<void> getWidgets() async {
    widgetListe.clear();
    final Firestore _firestore = Firestore.instance;
    QuerySnapshot querySnapshot =
        await _firestore.collection("widgetler").getDocuments();
    for (int i = 0; i < querySnapshot.documents.length; i++) {
      widgetListe.add(WidgetModel.fromJson(querySnapshot.documents[i].data));
    }
    update();
  }



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
        return a.yayinTarihi.compareTo(b.yayinTarihi);
      });
    }
    haberListe=haberListe.reversed.toList();
    update();
  }
}


