import 'package:flutter/material.dart';

class WidgetOrnekler {
  static Widget ornekgetir(String ornek) {
    switch (ornek) {
      case "Text":
        return Text("Metin");
        break;

      case "Icon":
        return Icon(Icons.account_box);
        break;

      case "AppBar":
        return AppBar(
          backgroundColor: Colors.blue,
          title: Text("Başlık"),
          leading: Icon(Icons.label_important),
        );
        break;

      case "Container":
        return Container(
          color: Colors.amber,
          height: 100,
          width: 100,
        );
        break;

      case "Column":
        return Column(
          children: <Widget>[
            Icon(Icons.looks_one),
            Icon(Icons.looks_two),
            Icon(Icons.looks_3),
          ],
        );
        break;

      case "Row":
        return Row(
          children: <Widget>[
            Icon(Icons.looks_one),
            Icon(Icons.looks_two),
            Icon(Icons.looks_3),
          ],
        );
        break;

      case "RaisedButton":
        return RaisedButton(
          onPressed: () {
            debugPrint("Butona Tıklanıldı!");
          },
          color: Colors.blue,
          child: Text("Buton "),
        );
        break;

      default:
        return Text("Örnek İçin Diğer Güncellemeyi Bekleyiniz...");
        break;
    }
  }
}
