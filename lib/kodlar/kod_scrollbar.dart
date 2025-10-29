import 'package:flutter/material.dart';

class ScrollbarKod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Widget " + (index + 1).toString()),
          );
        },
      ),
    );
  }
}
