import 'package:flutter/material.dart';

class RaisedButtonKod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            debugPrint("Butona Tıklanıldı!");
          },
          color: Colors.blue,
          child: Text("Buton "),
        ),
      ],
    );
  }
}
