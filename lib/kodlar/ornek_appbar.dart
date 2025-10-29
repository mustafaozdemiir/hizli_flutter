import 'package:flutter/material.dart';

class AppBarOrnek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
                title: Text("AppBar Örnek"),
                leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () => {debugPrint("Menü")}),
                backgroundColor: Colors.redAccent,
                actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.videocam),
                  onPressed: () => {debugPrint("Kamera")}),
              IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () => {debugPrint("Profil")})
            ])));
  }
}
