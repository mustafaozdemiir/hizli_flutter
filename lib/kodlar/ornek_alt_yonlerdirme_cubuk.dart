import 'package:flutter/material.dart';

class AltYonlendirmeCubugu extends StatefulWidget {
  @override
  _AltYonlendirmeCubuguState createState() => _AltYonlendirmeCubuguState();
}

class _AltYonlendirmeCubuguState extends State<AltYonlendirmeCubugu> {
  int _selectedTabIndex = 0;

  List _pages = [
    Text("Anasayfa"),
    Text("Ara"),
    Text("Sepet"),
    Text("Hesap"),
  ];

  _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: Text("codesundar"), backgroundColor: Colors.lightBlue[900]),
        body: Center(child: _pages[_selectedTabIndex]),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTabIndex,
          onTap: _changeIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Anasayfa")),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text("Ara")),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), title: Text("Sepet")),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), title: Text("Hesap")),
          ],
        ),
      ),
    );
  }
}
