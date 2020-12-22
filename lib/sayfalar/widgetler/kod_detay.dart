import 'package:flutter/material.dart';
import 'package:hizliflutter/kodlar/widget_ornekler.dart';
import 'package:hizliflutter/modeller/widget_model.dart';
import 'package:hizliflutter/servisler/kod_gosterimi/source_code_view.dart';

import 'method_listeleme.dart';

class KodDetay extends StatelessWidget {
  WidgetModel model;

  KodDetay(this.model);

  @override
  Widget build(BuildContext context) {
    List<Widget> tabKontrol;
    List<Widget> tabBar;
    int sayfaSayisi;
    if (model.kodDizin == 'eklenmedi') {
      sayfaSayisi = 1;
      tabKontrol = [
        Tab(
          icon: Icon(Icons.edit),
          text: "Özellikler",
        )
      ];
      tabBar = [MetodSayfasi(model)];
    } else {
      sayfaSayisi = 3;
      tabKontrol = [
        Tab(
          icon: Icon(Icons.edit),
          text: "Özellikler",
        ),
        Tab(
          icon: Icon(Icons.play_arrow),
          text: "Ön İzleme",
        ),
        Tab(
          icon: Icon(Icons.code),
          text: "Kod",
        )
      ];
      tabBar = [
        MetodSayfasi(model),
        WidgetOrnek(model.adi),
        KodGorunumu(model.kodDizin),
      ];
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: sayfaSayisi,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              tabs: tabKontrol,
            ),
            title: Center(
              child: Text(
                model.adi,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          body: TabBarView(
            children: tabBar,
          ),
        ),
      ),
    );
  }
}

class MetodSayfasi extends StatelessWidget {
  WidgetModel model;

  MetodSayfasi(this.model);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MethodListeleme(model.metodlar),
    );
  }
}

class KodGorunumu extends StatelessWidget {
  String kodDizin;

  KodGorunumu(this.kodDizin);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SourceCodeView(
        filePath: kodDizin,
      ),
    );
  }
}

class WidgetOrnek extends StatelessWidget {
  String kodAdi;

  WidgetOrnek(this.kodAdi);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: WidgetOrnekler.ornekgetir(kodAdi),
    );
  }
}
