import 'package:flutter/material.dart';

class SayfaGecis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('İlk Sayfa'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('İkinci Sayfa'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DigerSayfa()),
              );
            },
          ),
        ),
      ),
    );
  }
}

class DigerSayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İkinci Sayfa"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Geri Dön!'),
        ),
      ),
    );
  }
}
