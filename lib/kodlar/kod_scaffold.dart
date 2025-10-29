import 'package:flutter/material.dart';

class ScaffoldKod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scaffold Appbar"),
      ),
      body: Text("Scaffold body"),
      backgroundColor: Colors.green,
      bottomNavigationBar: Text("Bottom Navigation Bar"),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(
          Icons.add,
          semanticLabel: "Floating Action Button",
        ),
      ),
    );
  }
}
