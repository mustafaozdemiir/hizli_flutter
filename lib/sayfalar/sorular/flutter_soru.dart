import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/controllers/question_controller.dart';

class FlutterSoru extends StatefulWidget {
  @override
  _FlutterSoruState createState() => _FlutterSoruState();
}

class _FlutterSoruState extends State<FlutterSoru> {
  final QuestionController questionController = Get.put(QuestionController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Soru"),
      ),
      body: GetBuilder<QuestionController>(
          autoRemove: true,
          builder: (s) {
            if (s.soruListe.length > 1 &&
                s.soruListe.isNotEmpty &&
                s.soruListe != null &&
                s.soruNo.value < s.soruListe.length) {
              s.startTimer(s.soruListe[s.soruNo.value].zaman);
            }
            QuestionBanner questionBanner = QuestionBanner();
            return s.soruListe.length > 1 &&
                    s.soruListe.isNotEmpty &&
                    s.soruListe != null &&
                    s.soruNo.value < s.soruListe.length
                ? Obx(() {
                    if (s.soruListe.length > 1 &&
                        s.soruListe.isNotEmpty &&
                        s.soruListe != null &&
                        s.soruNo.value < s.soruListe.length) {
                      switch (s.soruListe[s.soruNo.value].zorluk) {
                        case "kolay":
                          questionBanner.bannerMessage = "Kolay";
                          questionBanner.bannerColor =
                              Colors.green.withOpacity(.4);
                          questionBanner.bannerTextColor = Colors.white;
                          questionBanner.zorlukRenk = Colors.blue;
                          break;

                        case "orta":
                          questionBanner.bannerMessage = "Orta";
                          questionBanner.bannerColor =
                              Colors.yellow.withOpacity(.7);
                          questionBanner.bannerTextColor = Colors.black;
                          questionBanner.zorlukRenk = Colors.yellow;
                          break;

                        case "zor":
                          questionBanner.bannerMessage = "Zor";
                          questionBanner.bannerColor =
                              Colors.red.withOpacity(.5);
                          questionBanner.bannerTextColor = Colors.white;
                          questionBanner.zorlukRenk = Colors.deepOrange;
                          break;

                        default:
                          questionBanner.bannerMessage = "";
                          questionBanner.bannerColor =
                              Colors.green.withOpacity(.4);
                          questionBanner.bannerTextColor = Colors.white;
                          questionBanner.zorlukRenk = Colors.blue;
                          break;
                      }
                    }
                    return Column(
                      children: [
                        Banner(
                          location: BannerLocation.topStart,
                          message: questionBanner.bannerMessage,
                          color: questionBanner.bannerColor,
                          textStyle:
                              TextStyle(color: questionBanner.bannerTextColor),
                          child: Card(
                            color: Colors.grey.shade300,
                            child: ListTile(
                              title: Text(
                                s.soruListe[s.soruNo.value].baslik,
                                style: TextStyle(color: Colors.black),
                              ),
                              leading: Text(
                                (s.soruNo.value + 1).toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                String secenek = "A";
                                switch (index) {
                                  case 0:
                                    secenek = "A";
                                    break;
                                  case 1:
                                    secenek = "B";
                                    break;
                                  case 2:
                                    secenek = "C";
                                    break;
                                  case 3:
                                    secenek = "D";
                                    break;
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Card(
                                    child: ListTile(
                                      tileColor: Colors.grey.shade300,
                                      leading: Text(secenek),
                                      title: Text(s.soruListe[s.soruNo.value]
                                          .cevaplar[index]),
                                      onTap: () {
                                        s.stopTimer();
                                        s.cevapKontrol(
                                            s.soruListe[s.soruNo.value],
                                            s.soruListe[s.soruNo.value]
                                                .cevaplar[index]);
                                      },
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Center(
                          child: Text(
                            s.time.toString(),
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Banner(
                          location: BannerLocation.bottomEnd,
                          message: s.sonCevap != null
                              ? s.sonCevap.value
                                  ? "Doğru"
                                  : "Yanlış"
                              : "",
                          color: s.sonCevap != null
                              ? s.sonCevap.value
                                  ? Colors.green
                                  : Colors.red
                              : Colors.white,
                          textStyle: TextStyle(
                              color: s.sonCevap != null
                                  ? s.sonCevap.value
                                      ? Colors.white
                                      : Colors.white
                                  : Colors.white),
                          child: Card(
                            color: Colors.blue.withOpacity(.1),
                            child: Container(
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.done,
                                          size: 40,
                                          color: Colors.green,
                                        ),
                                        Text(
                                          s.dogruSayisi.toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.clear,
                                          size: 40,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          s.yanlisSayisi.toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 60, right: 60.0),
                                  child: Wrap(
                                    children: [
                                      Icon(
                                        Icons.leaderboard_outlined,
                                        size:25,
                                        color: Colors.indigo,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        s.toplamPuan.toStringAsFixed(0),
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  })
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }



}
