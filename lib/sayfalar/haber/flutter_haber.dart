import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hizliflutter/modeller/haber.dart';

import 'haber_detay.dart';

class FlutterHaber extends StatefulWidget {
  @override
  _FlutterHaberState createState() => _FlutterHaberState();
}

class _FlutterHaberState extends State<FlutterHaber> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  List<Haber> modelListe;
  Widget zaman;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text("Flutter Haberler"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _yenile,
            child: Column(
              children: <Widget>[_listView()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listView() {
    String bannerMessage;
    Color bannerColor;
    Color bannerTextColor;
    return modelListe != null
        ? Expanded(
            child: ListView.builder(
                itemCount: modelListe.length,
                itemBuilder: (context, int index) {
                  if (DateTime.now()
                          .difference(modelListe[index].yayinTarihi.toDate())
                          .inDays ==
                      0) {
                    bannerMessage = "Yeni";
                    bannerColor = Colors.yellow;
                    bannerTextColor = Colors.black;
                  } else {
                    if (DateTime.now()
                            .difference(modelListe[index].yayinTarihi.toDate())
                            .inDays <
                        365) {
                      bannerMessage = DateTime.now()
                              .difference(
                                  modelListe[index].yayinTarihi.toDate())
                              .inDays
                              .toString() +
                          " Gün Önce";
                      bannerColor = Colors.green;
                      bannerTextColor = Colors.white;
                    } else if (365 <=
                            DateTime.now()
                                .difference(
                                    modelListe[index].yayinTarihi.toDate())
                                .inDays &&
                        DateTime.now()
                                .difference(
                                    modelListe[index].yayinTarihi.toDate())
                                .inDays <=
                            730) {
                      bannerMessage = "1 Yıl Önce";
                      bannerColor = Colors.purple;
                      bannerTextColor = Colors.white;
                    } else if (DateTime.now()
                            .difference(modelListe[index].yayinTarihi.toDate())
                            .inDays >
                        365) {
                      bannerMessage = "2 Yıl Önce";
                      bannerColor = Colors.black;
                      bannerTextColor = Colors.white;
                    }
                  }
                  /*Text(DateFormat('yyyy-MM-dd')
                          .format(modelListe[index].yayinTarihi.toDate())),*/
                  return Banner(
                    message: bannerMessage,
                    location: BannerLocation.topEnd,
                    textStyle: TextStyle(color: bannerTextColor, fontSize: 10),
                    color: bannerColor,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 3, color: Colors.lightBlue),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                        ),
                      ),
                      child: ListTile(
                        trailing: zaman,
                        leading: CachedNetworkImage(
                          imageUrl: modelListe[index].baslikResim,
                          placeholder: (context, url) =>
                              Image.asset('res/loading.gif'),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            semanticLabel: "Resim Kaldırılmış",
                            size: 50,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HaberDetay(modelListe[index]),
                            ),
                          );
                        },
                        title: Center(
                          child: Text(
                            modelListe[index].baslik,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(modelListe[index].kisaAciklama),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        : CircularProgressIndicator();
  }

  /*static onlineHaberGetir() async {
    List<Haber> liste = List<Haber>();

    final Firestore _firestore = Firestore.instance;
    QuerySnapshot querySnapshot =
        await _firestore.collection("haberler").getDocuments();

    for (int k = 0; k < querySnapshot.documents.length; k++) {
      List<String> resimler = List<String>();

      for (int i = 0; i < querySnapshot.documents[k]['resimler'].length; i++) {
        resimler.add(
          querySnapshot.documents[k].data['resimler'][i],
        );
      }
      liste.add(
        Haber(
          baslik: querySnapshot.documents[k].data['baslik']
              .toString()
              .replaceAll("/n", "\n"),
          kisaAciklama: querySnapshot.documents[k].data['kisaAciklama'],
          uzunAciklama: querySnapshot.documents[k].data['uzunAciklama'],
          kaynakLink: querySnapshot.documents[k].data['kaynakLink'],
          youtubeVideoUrl: querySnapshot.documents[k].data['youtubeVideoUrl'],
          resimler: resimler,
          cesidi: querySnapshot.documents[k].data['cesit'],
          turu: querySnapshot.documents[k].data['turu'],
          yayinTarihi: querySnapshot.documents[k].data['yayinTarihi'],
          baslikResim: querySnapshot.documents[k].data['baslikResim'],
        ),
      );
    }
    for (int i = 0; i < liste.length; i++) {
      liste.sort((a, b) {
        return a.yayinTarihi.compareTo(b.yayinTarihi);
      });
    }

    return liste.reversed.toList();
  }*/

  static onlineHaberGetir() async {
    List<Haber> liste = List<Haber>();

    final Firestore _firestore = Firestore.instance;
    QuerySnapshot querySnapshot =
        await _firestore.collection("haberler").getDocuments();

    for (int k = 0; k < querySnapshot.documents.length; k++) {
      liste.add(Haber.fromJson(querySnapshot.documents[k].data));
    }
    for (int i = 0; i < liste.length; i++) {
      liste.sort((a, b) {
        return a.yayinTarihi.compareTo(b.yayinTarihi);
      });
    }

    return liste.reversed.toList();
  }

  Future<void> _yenile() {
    return onlineHaberGetir().then((gelenListe) {
      setState(() {
        modelListe = gelenListe;
      });
    });
  }
}
