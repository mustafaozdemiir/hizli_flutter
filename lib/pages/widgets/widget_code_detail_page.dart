import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/app_string.dart';
import 'package:hizliflutter/kodlar/widget_ornekler.dart';
import 'package:hizliflutter/models/widget_model.dart';
import 'package:hizliflutter/services/show_code_service//source_code_view.dart';

import 'list_method_page.dart';

class WidgetCodeDetailPage extends StatelessWidget {
  WidgetModel model;

  WidgetCodeDetailPage(this.model);
  List<Widget> tabKontrol;
  List<Widget> tabBar;
  int sayfaSayisi;

  @override
  Widget build(BuildContext context) {

 hasSample();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: sayfaSayisi,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              tabs: tabKontrol,
            ),
            centerTitle: true,
            title: Text(
              model.name,
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          body: TabBarView(
            children: tabBar,
          ),
        ),
      ),
    );
  }

  void hasSample() {
    if (model.path == 'eklenmedi') {
      sayfaSayisi = 1;
      tabKontrol = [
        Tab(
          icon: Icon(Icons.edit),
          text: AppString.features,
        )
      ];
      tabBar = [MetodSayfasi(model)];
    } else {
      sayfaSayisi = 3;
      tabKontrol = [
        Tab(
          icon: Icon(Icons.edit),
          text: AppString.features,
        ),
        Tab(
          icon: Icon(Icons.play_arrow),
          text: AppString.preview,
        ),
        Tab(
          icon: Icon(Icons.code),
          text: AppString.code,
        )
      ];
      tabBar = [
        MetodSayfasi(model),
        WidgetOrnek(model.name),
        KodGorunumu(model.path),
      ];
    }
  }
}

class MetodSayfasi extends StatelessWidget {
  WidgetModel model;

  MetodSayfasi(this.model);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListMethodPage(model.methods),
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
