import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/app_string.dart';
import 'package:hizliflutter/models/sample.dart';
import 'package:hizliflutter/services/show_code_service/source_code_view.dart';

class SampleDetailPage extends StatefulWidget {
  Sample ornek;

  SampleDetailPage(this.ornek);

  @override
  _SampleDetailPageState createState() => _SampleDetailPageState(ornek);
}

class _SampleDetailPageState extends State<SampleDetailPage> {
  Sample ornek;

  _SampleDetailPageState(this.ornek);

  @override
  Widget build(BuildContext context) {
    List<Widget> tabBar = [
      WidgetOrnek(ornek.ornek),
      KodGorunumu(ornek.kod, ornek.kaynak),
    ];
    List<Widget> tabKontrol = [
      Tab(
        icon: Icon(Icons.play_arrow),
        text: AppString.preview,
      ),
      Tab(
        icon: Icon(Icons.code),
        text: AppString.code,
      )
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              ornek.adi,
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              tabs: tabKontrol,
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              },
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

class KodGorunumu extends StatelessWidget {
  String kodDizin;
  String kaynak;

  KodGorunumu(this.kodDizin, this.kaynak);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SourceCodeView(
        filePath: kodDizin,
        codeLinkPrefix: kaynak,
      ),
    );
  }
}

class WidgetOrnek extends StatelessWidget {
  Widget ornek;

  WidgetOrnek(this.ornek);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ornek,
      ),
    );
  }
}
