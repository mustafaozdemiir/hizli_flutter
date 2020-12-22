import 'package:flutter/material.dart';
import 'package:hizliflutter/modeller/ornek.dart';
import 'package:hizliflutter/servisler/kod_gosterimi/source_code_view.dart';

class OrnekDetay extends StatefulWidget {
  Ornek ornek;

  OrnekDetay(this.ornek);

  @override
  _OrnekDetayState createState() => _OrnekDetayState(ornek);
}

class _OrnekDetayState extends State<OrnekDetay> {
  Ornek ornek;

  _OrnekDetayState(this.ornek);

  @override
  Widget build(BuildContext context) {
    List<Widget> tabBar = [
      WidgetOrnek(ornek.ornek),
      KodGorunumu(ornek.kod, ornek.kaynak),
    ];
    List<Widget> tabKontrol = [
      Tab(
        icon: Icon(Icons.play_arrow),
        text: "Ön İzleme",
      ),
      Tab(
        icon: Icon(Icons.code),
        text: "Kod",
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
