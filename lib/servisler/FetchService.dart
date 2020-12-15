import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/modeller/haber.dart';
import 'package:hizliflutter/modeller/soru.dart';
import 'package:hizliflutter/modeller/widget_model.dart';

class FetchService extends GetxController {
  List<WidgetModel> widgetListe = List<WidgetModel>().obs;
  List<Soru> soruListe = List<Soru>();
  List<Haber> haberListe = List<Haber>();

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

  Future<void> getQuestion() async {
    soruListe.clear();
    final Firestore _firestore = Firestore.instance;
    QuerySnapshot querySnapshot =
        await _firestore.collection("sorular").getDocuments();
    for (int i = 0; i < querySnapshot.documents.length; i++) {
      soruListe.add(Soru.fromJson(querySnapshot.documents[i].data));
    }
    soruListe.shuffle();
    update();
  }

  Future<void> getNews() async {
    haberListe.clear();
    final Firestore _firestore = Firestore.instance;
    QuerySnapshot querySnapshot =
        await _firestore.collection("haberler").getDocuments();
    for (int i = 0; i < querySnapshot.documents.length; i++) {
      haberListe.add(Haber.fromJson(querySnapshot.documents[i].data));
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


