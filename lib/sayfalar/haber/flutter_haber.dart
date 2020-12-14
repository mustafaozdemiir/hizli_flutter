import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/modeller/haber.dart';
import 'package:hizliflutter/servisler/FetchService.dart';

import 'haber_detay.dart';

class FlutterHaber extends StatefulWidget {
  @override
  _FlutterHaberState createState() => _FlutterHaberState();
}

class _FlutterHaberState extends State<FlutterHaber> {

  List<Haber> modelListe;
  Widget zaman;

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
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text("Flutter Haberler"),
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<FetchService>(
        initState: (_) => Get.find<FetchService>().getNews(),
        builder: (s) {
          return s.haberListe.length < 1
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[_listView(s)],
                    ),
                  ),
                );
        },
      ),
    );
  }

  Widget _listView(FetchService s) {
    String bannerMessage;
    Color bannerColor;
    Color bannerTextColor;
    return s.haberListe != null
        ? Expanded(
            child: ListView.builder(
                itemCount: s.haberListe.length,
                itemBuilder: (context, int index) {
                  if (DateTime.now()
                          .difference(s.haberListe[index].yayinTarihi.toDate())
                          .inDays ==
                      0) {
                    bannerMessage = "Yeni";
                    bannerColor = Colors.yellow;
                    bannerTextColor = Colors.black;
                  } else {
                    if (DateTime.now()
                            .difference(s.haberListe[index].yayinTarihi.toDate())
                            .inDays <
                        365) {
                      bannerMessage = DateTime.now()
                              .difference(
                          s.haberListe[index].yayinTarihi.toDate())
                              .inDays
                              .toString() +
                          " Gün Önce";
                      bannerColor = Colors.green;
                      bannerTextColor = Colors.white;
                    } else if (365 <=
                            DateTime.now()
                                .difference(
                                s.haberListe[index].yayinTarihi.toDate())
                                .inDays &&
                        DateTime.now()
                                .difference(
                            s.haberListe[index].yayinTarihi.toDate())
                                .inDays <=
                            730) {
                      bannerMessage = "1 Yıl Önce";
                      bannerColor = Colors.purple;
                      bannerTextColor = Colors.white;
                    } else if (DateTime.now()
                            .difference(s.haberListe[index].yayinTarihi.toDate())
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
                          imageUrl: s.haberListe[index].baslikResim,
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
                                  HaberDetay(s.haberListe[index]),
                            ),
                          );
                        },
                        title: Center(
                          child: Text(
                            s.haberListe[index].baslik,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(s.haberListe[index].kisaAciklama),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        : CircularProgressIndicator();
  }


}
