import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hizliflutter/modeller/soru.dart';

class FlutterSoru extends StatefulWidget {
  @override
  _FlutterSoruState createState() => _FlutterSoruState();
}

class _FlutterSoruState extends State<FlutterSoru> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => _refreshIndicatorKey.currentState.show());
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Soru> sorular;
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

    if (sorular != null && soruNo < sorular.length) {
      switch (sorular[soruNo].zorluk) {
        case 'kolay':
          setState(() {
            bannerMessage = "Kolay";
            bannerColor = Colors.green;
            bannerTextColor = Colors.white;
            zorlukRenk = Colors.blue;
          });
          break;

        case 'orta':
          setState(() {
            bannerMessage = "Orta";
            bannerColor = Colors.yellow;
            bannerTextColor = Colors.black;
            zorlukRenk = Colors.yellow;
          });
          break;

        case 'zor':
          setState(() {
            bannerMessage = "Zor";
            bannerColor = Colors.red;
            bannerTextColor = Colors.white;
            zorlukRenk = Colors.deepOrange;
          });
          break;

        default:
          setState(() {
            zorlukRenk = Colors.blue;
          });
          break;
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text("Hızlı Soru"),
      ),
      body: Center(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _yenile,
          child: sorular == null
              ? CircularProgressIndicator()
              : soruNo < sorular.length
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
                                sorular[soruNo].baslik,
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
                            title: Text(sorular[soruNo].cevaplar[0]),
                            leading: Text("A"),
                            onTap: () {
                              if (cevapKontrol(sorular[soruNo],
                                  sorular[soruNo].cevaplar[0])) {
                                setState(() {
                                  renk = Colors.green;
                                  toplamPuan += sorular[soruNo].puan;
                                  sonCevap = true;
                                  dogruSayisi++;
                                });
                              } else {
                                setState(() {
                                  sonCevap = false;
                                  renk = Colors.red;
                                  toplamPuan -= sorular[soruNo].puan % 2 == 0
                                      ? sorular[soruNo].puan / 2
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
                            title: Text(sorular[soruNo].cevaplar[1]),
                            leading: Text("B"),
                            onTap: () {
                              if (cevapKontrol(sorular[soruNo],
                                  sorular[soruNo].cevaplar[1])) {
                                setState(() {
                                  sonCevap = true;
                                  renk2 = Colors.green;
                                  toplamPuan += sorular[soruNo].puan;
                                  dogruSayisi++;
                                });
                              } else {
                                setState(() {
                                  sonCevap = false;
                                  renk2 = Colors.red;
                                  toplamPuan -= sorular[soruNo].puan % 2 == 0
                                      ? sorular[soruNo].puan / 2
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
                            title: Text(sorular[soruNo].cevaplar[2]),
                            leading: Text("C"),
                            onTap: () {
                              if (cevapKontrol(sorular[soruNo],
                                  sorular[soruNo].cevaplar[2])) {
                                setState(() {
                                  sonCevap = true;
                                  renk3 = Colors.green;
                                  toplamPuan += sorular[soruNo].puan;
                                  dogruSayisi++;
                                });
                              } else {
                                setState(() {
                                  sonCevap = false;
                                  renk3 = Colors.red;
                                  toplamPuan -= sorular[soruNo].puan % 2 == 0
                                      ? sorular[soruNo].puan / 2
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
                            title: Text(sorular[soruNo].cevaplar[3]),
                            leading: Text("D"),
                            onTap: () {
                              if (cevapKontrol(sorular[soruNo],
                                  sorular[soruNo].cevaplar[3])) {
                                setState(() {
                                  sonCevap = true;
                                  renk4 = Colors.green;
                                  toplamPuan += sorular[soruNo].puan;
                                  dogruSayisi++;
                                });
                              } else {
                                setState(() {
                                  sonCevap = false;
                                  renk4 = Colors.red;
                                  toplamPuan -= sorular[soruNo].puan % 2 == 0
                                      ? sorular[soruNo].puan / 2
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
                                  child: Text(
                                    toplamPuan.toStringAsFixed(0),
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*  Center(
                          child: Text(
                            sorular[soruNo].zaman.toString(),
                            style: TextStyle(fontSize: 80),
                          ),
                        ),*/
                      ],
                    )
                  : Center(
                      child: Text(
                        "TOPLAM PUAN: " + (toplamPuan.toStringAsFixed(0)),
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
        ),
      ),
    );
  }

  static onlineSoruGetir() async {
    List<Soru> liste = List<Soru>();

    final Firestore _firestore = Firestore.instance;
    QuerySnapshot querySnapshot =
        await _firestore.collection("sorular").getDocuments();

    for (int k = 0; k < querySnapshot.documents.length; k++) {
      liste.add(Soru.fromJson(querySnapshot.documents[k].data));
    }
    liste.shuffle();
    return liste;
  }

  Future<void> _yenile() {
    if (mounted) {
      return onlineSoruGetir().then((gelenListe) {
        setState(() {
          sorular = gelenListe;
        });
      });
    }
  }
}
