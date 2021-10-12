import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/data/data.dart';
import 'package:hizliflutter/models/question.dart';

import '../app_string.dart';

class QuestionController extends GetxController {
  List<Question> soruListe;
  var soruNo = 0.obs;
  var timerTime = 10.obs;
  Timer timer;

  var toplamPuan = 0.0.obs;
  var zorlukRenk = Colors.blue.obs;
  var sonCevap = true.obs;

  var dogruSayisi = 0.obs;
  var yanlisSayisi = 0.obs;

  /* Future<void> getQuestion() async {
    soruListe = List<Question>();
    final Firestore _firestore = Firestore.instance;
    QuerySnapshot querySnapshot =
        await _firestore.collection("sorular").getDocuments();
    for (int i = 0; i < querySnapshot.documents.length; i++) {
      soruListe.add(Question.fromJson(querySnapshot.documents[i].data));
    }
    soruListe.shuffle();
    update();
  }*/

  Future<void> getQuestionApi() async {
    var parsedJson;

    parsedJson = await Data.get(isSecure: false, dataType: DataType.Question);
    soruListe = [];

    if (parsedJson.toString() != '[]') {
      for (var model in parsedJson) {
        soruListe.add(Question.fromJson(model));
      }
      soruListe.shuffle();
    }
    update();
  }

  void startTimer(int zaman) {
    if (timer != null) {
      timer.cancel();
    }
    timerTime.value = zaman;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerTime.value != 0) {
        timerTime.value--;
      } else if (timerTime.value == 0) {
        if (soruNo.value == soruListe.length - 1) {
          soruBitis();
        } else {
          bos_cevap();
        }
      }
    });
  }

  void stopTimer() {
    timer.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  void onInit() {
    getQuestionApi();
    super.onInit();
  }

  void cevapKontrol(Question gelenSoru, String gelenCevap) {
    if (gelenSoru.answer.compareTo(gelenCevap) == 0) {
      dogru_cevap();
    } else {
      yanlis_cevap();
    }
  }

  void bos_cevap() {
    Get.snackbar(AppString.timeIsUp, AppString.newQuestionComing,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
    sonCevap.value = false;
    toplamPuan.value -= soruListe[soruNo.value].point % 2 == 0
        ? soruListe[soruNo.value].point / 2
        : 3;
    yanlisSayisi.value++;
    if (soruNo.value < soruListe.length) {
      nextQuestion();
    } else {
      soruNo.value = 0;
      soruNo.refresh();
    }
    update();
  }

  void yanlis_cevap() {
    sonCevap.value = false;
    toplamPuan.value -= soruListe[soruNo.value].point % 2 == 0
        ? soruListe[soruNo.value].point / 2
        : 3;
    yanlisSayisi.value++;
    Get.snackbar(AppString.wrong, AppString.sorryWrongAnswer,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP);

    nextQuestion();
  }

  void dogru_cevap() {
    toplamPuan.value += soruListe[soruNo.value].point;
    sonCevap.value = true;
    dogruSayisi.value++;
    Get.snackbar(AppString.correct, AppString.congratsOnTheCorrectAnswer,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP);
    nextQuestion();
  }

  void nextQuestion() {
    if (soruNo.value < soruListe.length - 1) {
      if (timer.isActive) {
        stopTimer();
      }
      soruNo.value++;
      soruNo.refresh();
      startTimer(soruListe[soruNo.value].time);
    } else {
      soruBitis();
    }
  }

  void soruBitis() {
    Get.dialog(
        AlertDialog(
          title: Text(AppString.questionsDone),
          content: Text(
            AppString.numberOfCorrect +
                ': ' +
                dogruSayisi.value.toString() +
                '\n' +
                AppString.numberOfInCorrect +
                ': ' +
                yanlisSayisi.value.toString() +
                '\n' +
                AppString.totalPoints +
                ': ' +
                toplamPuan.toStringAsFixed(0),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                soruNo.value = 0;
                dogruSayisi.value = 0;
                yanlisSayisi.value = 0;
                toplamPuan.value = 0;
                dogruSayisi.refresh();
                yanlisSayisi.refresh();
                toplamPuan.refresh();
                Get.back();
                startTimer(soruListe[soruNo.value].time);
              },
              child: Text(AppString.ok),
            ),
          ],
        ),
        barrierDismissible: false,
        transitionCurve: Curves.easeOutSine,
        transitionDuration: Duration(seconds: 1),
        barrierColor: Colors.blue);
    stopTimer();
  }
}

class QuestionBanner {
  String bannerMessage;
  Color bannerColor;
  Color bannerTextColor;
  Color zorlukRenk;

  QuestionBanner();
}
