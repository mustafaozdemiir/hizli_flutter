import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/servisler/FetchService.dart';
import 'kod_detay.dart';
import 'dart:math';

class WidgetListeleme extends StatefulWidget {
  @override
  _WidgetListelemeState createState() => _WidgetListelemeState();
}

class _WidgetListelemeState extends State<WidgetListeleme> {
  final FetchService fetchServiceController = Get.put(FetchService());

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
  }

  @override
  void dispose() {
    super.dispose();
    _searchEdit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text("Widgetler"),
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<FetchService>(
        initState: (_) => Get.find<FetchService>().getWidgets(),
        builder: (s) {
          return s.widgetListe.length < 1
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    _arama(),
                    _isSearch ? _listView(s) : _searchListView(s)
                  ],
                );
        },
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

  Widget _listView(FetchService s) {
    return Expanded(
      child: ListView.builder(
          itemCount: s.widgetListe.length,
          itemBuilder: (context, int index) {
            String messageBanner;
            Color bannerColor;
            Color bannerTextColor;
            Widget cesit;

            switch (s.widgetListe[index].kodTuru) {
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

            switch (s.widgetListe[index].cesit) {
              case 'Layout':
                cesit = Text(
                  s.widgetListe[index].cesit,
                  style: TextStyle(color: Colors.yellow[900]),
                );
                break;
              case 'Widget':
                cesit = Text(
                  s.widgetListe[index].cesit,
                  style: TextStyle(color: Colors.blue),
                );
                break;
              default:
                cesit = Text(
                  s.widgetListe[index].cesit,
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
                        builder: (context) => KodDetay(s.widgetListe[index]),
                      ),
                    );
                  },
                  title: Center(
                    child: Text(
                      s.widgetListe[index].adi,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(s.widgetListe[index].kisaAciklama),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _searchListView(FetchService s) {
    _liste = List<String>();
    for (int i = 0; i < s.widgetListe.length; i++) {
      _liste.add(s.widgetListe[i].adi);
    }

    _arananliste = List<String>();
    for (int i = 0; i < _liste.length; i++) {
      var item = _liste[i];

      if (item.toLowerCase().contains(_searchText.toLowerCase())) {
        _arananliste.add(item);
      }
    }
    return _searchAddList(s);
  }

  Widget _searchAddList(FetchService s) {
    return Flexible(
      child: ListView.builder(
          itemCount: _arananliste.length,
          itemBuilder: (context, int index) {
            String messageBanner;
            Color bannerColor;
            Color bannerTextColor;
            Widget cesit;

            switch (s.widgetListe[index].kodTuru) {
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
            switch (s.widgetListe[index].cesit) {
              case 'Layout':
                cesit = Text(
                  s.widgetListe[index].cesit,
                  style: TextStyle(color: Colors.yellow[900]),
                );
                break;
              case 'Widget':
                cesit = Text(
                  s.widgetListe[index].cesit,
                  style: TextStyle(color: Colors.blue),
                );
                break;
              default:
                cesit = Text(
                  s.widgetListe[index].cesit,
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
                            s.widgetListe[_liste.indexOf(_arananliste[index])]),
                      ),
                    );
                  },
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(s
                          .widgetListe[_liste.indexOf(_arananliste[index])]
                          .adi),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(s
                          .widgetListe[_liste.indexOf(_arananliste[index])]
                          .kisaAciklama),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
