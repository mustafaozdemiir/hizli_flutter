import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/controllers/auth/auth_controller.dart';
import 'package:hizliflutter/main.dart';

class SplashPage extends StatelessWidget {
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: AnimatedTextKit(
            onFinished: () {
              authController.isLoginFunction().then((value) => {
              });
              Get.offAll(MyHomePage());
            },
            animatedTexts: [
              WavyAnimatedText(
                'HIZLI FLUTTER',
                speed: Duration(milliseconds: 200),
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                    fontSize: 50),
              ),
            ],
            isRepeatingAnimation: false,
          ),
        ));
  }
}
