import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/data/data.dart';
import 'package:hizliflutter/models/question.dart';

import '../app_string.dart';

class QuestionController extends GetxController {
  RxList<Question> soruListe = <Question>[].obs;
  var soruNo = 0.obs;
  var timerTime = 10.obs;
  Timer? timer;

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
    soruListe.clear();

    if (parsedJson.toString() != '[]') {
      for (var model in parsedJson) {
        soruListe.add(Question.fromJson(model));
      }
      soruListe.shuffle();
    }
  }

  Question? get currentQuestion {
    if (soruListe.isEmpty) return null;
    if (soruNo.value < 0 || soruNo.value >= soruListe.length) return null;
    return soruListe[soruNo.value];
  }

  void startTimer(int zaman) {
    // Cancel any existing timer safely
    if (timer != null) {
      try {
        timer!.cancel();
      } catch (e) {}
      timer = null;
    }

    // Ensure we have a valid question to start timer for
    if (currentQuestion == null) return;

    timerTime.value = zaman;
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (timerTime.value != 0) {
        timerTime.value--;
      } else {
        // time's up
        // stop current timer before handling
        stopTimer();
        if (soruNo.value == (soruListe.length) - 1) {
          soruBitis();
        } else {
          bos_cevap();
        }
      }
    });
  }

  void stopTimer() {
    try {
      if (timer?.isActive ?? false) {
        timer?.cancel();
      }
    } catch (e) {}
    timer = null;
  }

  @override
  void dispose() {
    try {
      if (timer?.isActive ?? false) timer?.cancel();
    } catch (e) {}
    timer = null;
    super.dispose();
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
    if (currentQuestion != null) {
      toplamPuan.value -=
          currentQuestion!.point % 2 == 0 ? currentQuestion!.point / 2 : 3;
    }
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
    if (currentQuestion != null) {
      toplamPuan.value -=
          currentQuestion!.point % 2 == 0 ? currentQuestion!.point / 2 : 3;
    }
    yanlisSayisi.value++;
    Get.snackbar(AppString.wrong, AppString.sorryWrongAnswer,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP);

    nextQuestion();
  }

  void dogru_cevap() {
    if (currentQuestion != null) toplamPuan.value += currentQuestion!.point;
    sonCevap.value = true;
    dogruSayisi.value++;
    Get.snackbar(AppString.correct, AppString.congratsOnTheCorrectAnswer,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP);
    nextQuestion();
  }

  void nextQuestion() {
    if (soruListe.isEmpty) return;
    if (soruNo.value < soruListe.length - 1) {
      if (timer?.isActive ?? false) {
        stopTimer();
      }
      soruNo.value++;
      soruNo.refresh();
      // start timer for new question if available
      if (currentQuestion != null) startTimer(currentQuestion!.time);
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
            ElevatedButton(
              onPressed: () {
                soruNo.value = 0;
                dogruSayisi.value = 0;
                yanlisSayisi.value = 0;
                toplamPuan.value = 0;
                dogruSayisi.refresh();
                yanlisSayisi.refresh();
                toplamPuan.refresh();
                Get.back();
                if (soruListe.isNotEmpty) {
                  startTimer(soruListe[soruNo.value].time);
                }
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
  String? bannerMessage;
  Color? bannerColor;
  Color? bannerTextColor;
  Color? zorlukRenk;

  QuestionBanner();
}
