import 'package:flutter/material.dart';

class PlaceHolderKod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 200,
        height: 200,
        color: Colors.white,
        child: Placeholder(
          color: Colors.blue[50],
        ),
      ),
    );
  }
}
