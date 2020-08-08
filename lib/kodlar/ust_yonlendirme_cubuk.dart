import 'package:flutter/material.dart';

class UstYonlendirmeCubugu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Yazılım Motoru"),
              leading: Icon(Icons.menu),
              backgroundColor: Colors.teal[700],
              actions: <Widget>[
                IconButton(icon: Icon(Icons.search), onPressed: () => {}),
                IconButton(icon: Icon(Icons.more_vert), onPressed: () => {})
              ],
              bottom: TabBar(
                indicatorColor: Colors.yellow,
                tabs: <Widget>[
                  Tab(text: "Konuşmalar", icon: Icon(Icons.chat)),
                  Tab(text: "Gruplar", icon: Icon(Icons.group)),
                  Tab(text: "Ayarlar", icon: Icon(Icons.settings))
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Center(child: Text("Konuşma Ekranı")),
                Center(child: Text("Gruplar Ekranı")),
                Center(child: Text("Ayarlar Ekranı")),
              ],
            ),
          ),
        ));
  }
}
