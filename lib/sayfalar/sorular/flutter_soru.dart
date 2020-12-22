import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/modeller/soru.dart';
import 'package:hizliflutter/servisler/FetchService.dart';

class FlutterSoru extends StatefulWidget {
  @override
  _FlutterSoruState createState() => _FlutterSoruState();
}

class _FlutterSoruState extends State<FlutterSoru> {
  final FetchService fetchServiceController = Get.put(FetchService());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int soruNo = 0;
  Color renk = Colors.white;
  Color renk2 = Colors.white;
  Color renk3 = Colors.white;
  Color renk4 = Colors.white;
  double toplamPuan = 0;
  Color zorlukRenk = Colors.blue;
  bool sonCevap;

  int dogruSayisi = 0;
  int yanlisSayisi = 0;

  bool cevapKontrol(Soru gelenSoru, String gelenCevap) {
    if (gelenSoru.cevap.compareTo(gelenCevap) == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    String bannerMessage;
    Color bannerColor;
    Color bannerTextColor;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Soru"),
        ),
        body: GetBuilder<FetchService>(
            initState: (_) => Get.find<FetchService>().getQuestion(),
            builder: (s) {
              if (s.soruListe.length > 1 && soruNo < s.soruListe.length) {
                QuestionBanner q =
                    QuestionBanner(zorluk: s.soruListe[soruNo].zorluk);
                bannerMessage = q.bannerMessage;
                bannerTextColor = q.bannerTextColor;
                bannerColor = q.bannerColor;
                zorlukRenk = q.zorlukRenk;
              }
              return s.soruListe.length > 1
                  ? soruNo < s.soruListe.length
                      ? ListView(
                          children: <Widget>[
                            Banner(
                              location: BannerLocation.topStart,
                              message: bannerMessage,
                              color: bannerColor,
                              textStyle: TextStyle(color: bannerTextColor),
                              child: Card(
                                color: Colors.grey.shade300,
                                child: ListTile(
                                  title: Text(
                                    s.soruListe[soruNo].baslik,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  leading: Text(
                                    (soruNo + 1).toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              color: renk,
                              child: ListTile(
                                title: Text(s.soruListe[soruNo].cevaplar[0]),
                                leading: Text("A"),
                                onTap: () {
                                  if (cevapKontrol(s.soruListe[soruNo],
                                      s.soruListe[soruNo].cevaplar[0])) {
                                    setState(() {
                                      renk = Colors.green;
                                      toplamPuan += s.soruListe[soruNo].puan;
                                      sonCevap = true;
                                      dogruSayisi++;
                                    });
                                  } else {
                                    setState(() {
                                      sonCevap = false;
                                      renk = Colors.red;
                                      toplamPuan -=
                                          s.soruListe[soruNo].puan % 2 == 0
                                              ? s.soruListe[soruNo].puan / 2
                                              : 3;
                                      yanlisSayisi++;
                                    });
                                  }
                                  setState(() {
                                    renk = Colors.white;
                                    renk2 = Colors.white;
                                    renk3 = Colors.white;
                                    renk4 = Colors.white;

                                    soruNo++;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              color: renk2,
                              child: ListTile(
                                title: Text(s.soruListe[soruNo].cevaplar[1]),
                                leading: Text("B"),
                                onTap: () {
                                  if (cevapKontrol(s.soruListe[soruNo],
                                      s.soruListe[soruNo].cevaplar[1])) {
                                    setState(() {
                                      sonCevap = true;
                                      renk2 = Colors.green;
                                      toplamPuan += s.soruListe[soruNo].puan;
                                      dogruSayisi++;
                                    });
                                  } else {
                                    setState(() {
                                      sonCevap = false;
                                      renk2 = Colors.red;
                                      toplamPuan -=
                                          s.soruListe[soruNo].puan % 2 == 0
                                              ? s.soruListe[soruNo].puan / 2
                                              : 3;
                                      yanlisSayisi++;
                                    });
                                  }
                                  setState(() {
                                    renk = Colors.white;
                                    renk2 = Colors.white;
                                    renk3 = Colors.white;
                                    renk4 = Colors.white;
                                    soruNo++;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              color: renk3,
                              child: ListTile(
                                title: Text(s.soruListe[soruNo].cevaplar[2]),
                                leading: Text("C"),
                                onTap: () {
                                  if (cevapKontrol(s.soruListe[soruNo],
                                      s.soruListe[soruNo].cevaplar[2])) {
                                    setState(() {
                                      sonCevap = true;
                                      renk3 = Colors.green;
                                      toplamPuan += s.soruListe[soruNo].puan;
                                      dogruSayisi++;
                                    });
                                  } else {
                                    setState(() {
                                      sonCevap = false;
                                      renk3 = Colors.red;
                                      toplamPuan -=
                                          s.soruListe[soruNo].puan % 2 == 0
                                              ? s.soruListe[soruNo].puan / 2
                                              : 3;
                                      yanlisSayisi++;
                                    });
                                  }
                                  setState(() {
                                    renk = Colors.white;
                                    renk2 = Colors.white;
                                    renk3 = Colors.white;
                                    renk4 = Colors.white;
                                    soruNo++;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              color: renk4,
                              child: ListTile(
                                title: Text(s.soruListe[soruNo].cevaplar[3]),
                                leading: Text("D"),
                                onTap: () {
                                  if (cevapKontrol(s.soruListe[soruNo],
                                      s.soruListe[soruNo].cevaplar[3])) {
                                    setState(() {
                                      sonCevap = true;
                                      renk4 = Colors.green;
                                      toplamPuan += s.soruListe[soruNo].puan;
                                      dogruSayisi++;
                                    });
                                  } else {
                                    setState(() {
                                      sonCevap = false;
                                      renk4 = Colors.red;
                                      toplamPuan -=
                                          s.soruListe[soruNo].puan % 2 == 0
                                              ? s.soruListe[soruNo].puan / 2
                                              : 3;
                                      yanlisSayisi++;
                                    });
                                  }
                                  setState(() {
                                    renk = Colors.white;
                                    renk2 = Colors.white;
                                    renk3 = Colors.white;
                                    renk4 = Colors.white;
                                    soruNo++;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Banner(
                              location: BannerLocation.bottomEnd,
                              message: sonCevap != null
                                  ? sonCevap
                                      ? "Doğru"
                                      : "Yanlış"
                                  : "",
                              color: sonCevap != null
                                  ? sonCevap
                                      ? Colors.green
                                      : Colors.red
                                  : Colors.white,
                              textStyle: TextStyle(
                                  color: sonCevap != null
                                      ? sonCevap
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
                                              size: 50,
                                              color: Colors.green,
                                            ),
                                            Text(
                                              dogruSayisi.toString(),
                                              style: TextStyle(fontSize: 25),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.clear,
                                              size: 50,
                                              color: Colors.red,
                                            ),
                                            Text(
                                              yanlisSayisi.toString(),
                                              style: TextStyle(fontSize: 25),
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
                                            size: 32,
                                            color: Colors.indigo,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            toplamPuan.toStringAsFixed(0),
                                            style: TextStyle(fontSize: 30),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Text(
                            "TOPLAM PUAN: " + (toplamPuan.toStringAsFixed(0)),
                            style: TextStyle(fontSize: 40),
                          ),
                        )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }));
  }
}

class QuestionBanner {
  String bannerMessage;
  Color bannerColor;
  Color bannerTextColor;
  Color zorlukRenk;

  QuestionBanner({String zorluk}) {
    switch (zorluk) {
      case "kolay":
        this.bannerMessage = "Kolay";
        this.bannerColor = Colors.green.withOpacity(.4);
        this.bannerTextColor = Colors.white;
        this.zorlukRenk = Colors.blue;
        break;

      case "orta":
        this.bannerMessage = "Orta";
        this.bannerColor = Colors.yellow.withOpacity(.7);
        this.bannerTextColor = Colors.black;
        this.zorlukRenk = Colors.yellow;
        break;

      case "zor":
        this.bannerMessage = "Zor";
        this.bannerColor = Colors.red.withOpacity(.5);
        this.bannerTextColor = Colors.white;
        this.zorlukRenk = Colors.deepOrange;
        break;

      default:
        zorlukRenk = Colors.blue;
        break;
    }
  }
}
