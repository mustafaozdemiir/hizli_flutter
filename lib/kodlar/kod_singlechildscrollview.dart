import 'package:flutter/material.dart';

class SingleChildScrollViewKod extends StatelessWidget {
  final TextStyle textstyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  final InputDecoration decoration =
      InputDecoration(border: OutlineInputBorder());

  @override
  Widget build(BuildContext context) {
    @override
    Widget build(BuildContext context) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(
                size: 190,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(),
              SizedBox(
                height: 15,
              ),
              TextFormField(),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                onPressed: () {},
                color: Colors.red,
                minWidth: 160,
                child: Text(
                  'Google',
                ),
              ),
              MaterialButton(
                onPressed: () {},
                color: Colors.blue,
                minWidth: 160,
                child: Text(
                  'Facebook',
                ),
              ),
              MaterialButton(
                onPressed: () {},
                color: Colors.orange,
                minWidth: 160,
                child: Text(
                  'E-mail',
                ),
              ),
              SizedBox(
                height: 50,
              ),
              FlutterLogo(
                size: 190,
              ),
            ],
          ),
        ),
      );
    }
  }
}
