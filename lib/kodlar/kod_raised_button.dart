import 'package:flutter/material.dart';

class RaisedButtonKod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            debugPrint("Butona Tıklanıldı!");
          },
          child: Text("Buton "),
        ),
      ],
    );
  }
}
