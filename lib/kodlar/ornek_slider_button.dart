import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slider_button/slider_button.dart';

class SliderButtonOrnek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SliderButton(
        action: () {
          Get.snackbar("Başarıli", "Kilit Açıldı!",
              colorText: Colors.white, backgroundColor: Colors.green);
        },
        label: Text("Kilidi Aç"),
        icon: Icon(Icons.lock_open),
      )),
    );
  }
}
