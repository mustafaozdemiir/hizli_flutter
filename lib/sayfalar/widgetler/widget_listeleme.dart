import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hizliflutter/modeller/widget_model.dart';

import 'kod_detay.dart';

import 'dart:math';

class WidgetListeleme extends StatefulWidget {
  @override
  _WidgetListelemeState createState() => _WidgetListelemeState();
}

class _WidgetListelemeState extends State<WidgetListeleme> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<WidgetModel> modelListe;
  List<WidgetModel> onlineListe;

  TextEditingController _searchEdit = TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

  List<String> _liste;
  List<String> _arananliste;

  _WidgetListelemeState() {
    _searchEdit.addListener(() {
      if (_searchEdit.text.isEmpty) {
        setState(() {
          _isSearch = true;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          _searchText = _searchEdit.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    onlineWidgetGetir().then((value) {
      modelListe = value;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text("Widgetler"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _yenile,
            child: Column(
              children: <Widget>[
                _arama(),
                SizedBox(
                  height: 8,
                ),
                _isSearch ? _listView() : _searchListView()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _arama() {
    return Card(
      shadowColor: Colors.black,
      shape: OutlineInputBorder(
        borderSide: BorderSide(width: 3, color: Colors.grey[700]),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(38),
          topLeft: Radius.circular(38),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          autofocus: false,
          controller: _searchEdit,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Widget Ara...",
            hintStyle: TextStyle(color: Colors.grey[300]),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _listView() {
    return modelListe != null
        ? Expanded(
            child: ListView.builder(
                itemCount: modelListe.length,
                itemBuilder: (context, int index) {
                  String messageBanner;
                  Color bannerColor;
                  Color bannerTextColor;
                  Widget cesit;

                  switch (modelListe[index].kodTuru) {
                    case 'basit':
                      messageBanner = "Basit";
                      bannerColor = Colors.green;
                      bannerTextColor = Colors.white;
                      break;
                    case 'orta':
                      messageBanner = "Orta";
                      bannerColor = Colors.yellow;
                      bannerTextColor = Colors.black;
                      break;
                    case 'zor':
                      messageBanner = "Zor";
                      bannerColor = Colors.red;
                      bannerTextColor = Colors.white;
                      break;
                  }

                  switch (modelListe[index].cesit) {
                    case 'Layout':
                      cesit = Text(
                        modelListe[index].cesit,
                        style: TextStyle(color: Colors.yellow[900]),
                      );
                      break;
                    case 'Widget':
                      cesit = Text(
                        modelListe[index].cesit,
                        style: TextStyle(color: Colors.blue),
                      );
                      break;
                    default:
                      cesit = Text(
                        modelListe[index].cesit,
                        style: TextStyle(
                            color: Color(
                                    (Random().nextDouble() * 0xFFFFFF).toInt())
                                .withOpacity(1.0)),
                      );
                  }

                  return Banner(
                    message: messageBanner,
                    location: BannerLocation.topStart,
                    color: bannerColor,
                    textStyle: TextStyle(color: bannerTextColor),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 3, color: Colors.lightBlue),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                        ),
                      ),
                      child: ListTile(
                        trailing: cesit,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KodDetay(modelListe[index]),
                            ),
                          );
                        },
                        title: Center(
                          child: Text(
                            modelListe[index].adi,
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

  Widget _searchListView() {
    _arananliste = List<String>();
    for (int i = 0; i < _liste.length; i++) {
      var item = _liste[i];

      if (item.toLowerCase().contains(_searchText.toLowerCase())) {
        _arananliste.add(item);
      }
    }
    return _searchAddList();
  }

  Widget _searchAddList() {
    return Flexible(
      child: ListView.builder(
          itemCount: _arananliste.length,
          itemBuilder: (context, int index) {
            String messageBanner;
            Color bannerColor;
            Color bannerTextColor;
            Widget cesit;

            switch (modelListe[index].kodTuru) {
              case 'basit':
                messageBanner = "Basit";
                bannerColor = Colors.green;
                bannerTextColor = Colors.white;
                break;
              case 'orta':
                messageBanner = "Orta";
                bannerColor = Colors.yellow;
                bannerTextColor = Colors.black;
                break;
              case 'zor':
                messageBanner = "Zor";
                bannerColor = Colors.red;
                bannerTextColor = Colors.white;
                break;
            }
            switch (modelListe[index].cesit) {
              case 'Layout':
                cesit = Text(
                  modelListe[index].cesit,
                  style: TextStyle(color: Colors.yellow[900]),
                );
                break;
              case 'Widget':
                cesit = Text(
                  modelListe[index].cesit,
                  style: TextStyle(color: Colors.blue),
                );
                break;
              default:
                cesit = Text(
                  modelListe[index].cesit,
                  style: TextStyle(
                      color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0)),
                );
            }
            return Banner(
              message: messageBanner,
              location: BannerLocation.topStart,
              color: bannerColor,
              textStyle: TextStyle(color: bannerTextColor),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 6, color: Colors.lightBlue),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: ListTile(
                  trailing: cesit,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KodDetay(
                            modelListe[_liste.indexOf(_arananliste[index])]),
                      ),
                    );
                  },
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                          modelListe[_liste.indexOf(_arananliste[index])].adi),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                          modelListe[_liste.indexOf(_arananliste[index])]
                              .kisaAciklama),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  static onlineWidgetGetir() async {
    List<WidgetModel> liste = List<WidgetModel>();

    final Firestore _firestore = Firestore.instance;
    QuerySnapshot querySnapshot =
        await _firestore.collection("widgetler").getDocuments();

    for (int k = 0; k < querySnapshot.documents.length; k++) {
      List<WidgetMetod> metodlar = List<WidgetMetod>();

      liste.add(WidgetModel(
        adi: querySnapshot.documents[k].data['adi']
            .toString()
            .replaceAll("/n", "\n"),
        kisaAciklama: querySnapshot.documents[k].data['kisaAciklama'],
        uzunAciklama: querySnapshot.documents[k].data['uzunAciklama'],
        kodTuru: querySnapshot.documents[k].data['kodTuru'],
        kodDizin: querySnapshot.documents[k].data['kodDizin'],
        metodlar: metodlar,
        cesit: querySnapshot.documents[k].data['cesit'],
      ));
      for (int z = 0; z < metodlar.length; z++) {}

      for (int i = 0; i < querySnapshot.documents[k]['metodlar'].length; i++) {
        metodlar.add(WidgetMetod(
          adi: querySnapshot.documents[k].data['metodlar'][i]['adi']
              .toString()
              .replaceAll("/n", "\n"),
          turu: querySnapshot.documents[k].data['metodlar'][i]['turu'],
          aciklama: querySnapshot.documents[k].data['metodlar'][i]['aciklama'],
        ));
      }
    }
    return liste;
  }

  Future<void> _yenile() {
    return onlineWidgetGetir().then((gelenListe) {
      setState(() {
        modelListe = gelenListe;
      });

      try {
        _liste = List<String>();
        for (int i = 0; i < modelListe.length; i++) {
          _liste.add(modelListe[i].adi);
        }
      } catch (_) {
        debugPrint("*****Hata***** " + _.toString());
      }
    });
  }
}
