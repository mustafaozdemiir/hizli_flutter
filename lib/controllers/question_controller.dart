import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/modeller/soru.dart';

class QuestionController extends GetxController {
  List<Soru> soruListe;
  var soruNo = 0.obs;
  var time = 10.obs;
  Timer _timer;

  var toplamPuan = 0.0.obs;
  var zorlukRenk = Colors.blue.obs;
  var sonCevap = true.obs;

  var dogruSayisi = 0.obs;
  var yanlisSayisi = 0.obs;

  Future<void> getQuestion() async {
    soruListe = List<Soru>();
    final Firestore _firestore = Firestore.instance;
    QuerySnapshot querySnapshot =
        await _firestore.collection("sorular").getDocuments();
    for (int i = 0; i < querySnapshot.documents.length; i++) {
      soruListe.add(Soru.fromJson(querySnapshot.documents[i].data));
    }
    soruListe.shuffle();
    update();
  }

  void startTimer(int zaman) {
    if (_timer != null) {
      _timer.cancel();
    }
    time.value = zaman;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (time.value != 0) {
        time.value--;
      } else if (time.value == 0) {
        if (soruNo.value == soruListe.length - 1) {
          soruBitis();
        } else {
          bos_cevap();
        }
      }
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void onInit() {
    getQuestion();
    super.onInit();
  }

  void cevapKontrol(Soru gelenSoru, String gelenCevap) {
    if (gelenSoru.cevap.compareTo(gelenCevap) == 0) {
      dogru_cevap();
    } else {
      yanlis_cevap();
    }
  }

  void bos_cevap() {
    Get.snackbar("Zaman Doldu", "Zaman doldu! Yeni soru geliyor...",
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
    sonCevap.value = false;
    toplamPuan.value -= soruListe[soruNo.value].puan % 2 == 0
        ? soruListe[soruNo.value].puan / 2
        : 3;
    yanlisSayisi.value++;
    if (soruNo.value < soruListe.length) {
      nextQuestion();
    }
  }

  void yanlis_cevap() {
    sonCevap.value = false;
    toplamPuan.value -= soruListe[soruNo.value].puan % 2 == 0
        ? soruListe[soruNo.value].puan / 2
        : 3;
    yanlisSayisi.value++;
    Get.snackbar("Yanlış", "Malesef yanlış cevap!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP);

    nextQuestion();
  }

  void dogru_cevap() {
    toplamPuan.value += soruListe[soruNo.value].puan;
    sonCevap.value = true;
    dogruSayisi.value++;
    Get.snackbar("Doğru", "Tebrikler doğru cevap!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP);
    nextQuestion();
  }

  void soruBitis() {
    Get.dialog(
        AlertDialog(
          title: Text("Sorular Bitti 1"),
          content: Text("Toplam Puanınız: " + toplamPuan.toStringAsFixed(0)),
          actions: [
            FlatButton(
                onPressed: () {
                  soruNo.value = 0;
                  soruNo.refresh();
                  dogruSayisi.value = 0;
                  yanlisSayisi.value = 0;
                  toplamPuan.value = 0;
                  dogruSayisi.refresh();
                  yanlisSayisi.refresh();
                  toplamPuan.refresh();
                  Get.back();
                  nextQuestion();
                },
                child: Text("Tamam"))
          ],
        ),
        barrierDismissible: false,
        transitionCurve: Curves.easeOutSine,
        transitionDuration: Duration(seconds: 1),
        barrierColor: Colors.blue);
    soruNo.value = 0;
    soruNo.refresh();
  }

  void nextQuestion() {
    if (soruNo.value != soruListe.length - 1) {
      if (_timer.isActive) {
        stopTimer();
      }
      soruNo.value++;
      soruNo.refresh();
      startTimer(soruListe[soruNo.value].zaman);
    } else if (soruNo.value < soruListe.length) {
      soruBitis();
    }
  }
}

class QuestionBanner {
  String bannerMessage;
  Color bannerColor;
  Color bannerTextColor;
  Color zorlukRenk;

  QuestionBanner();
}
