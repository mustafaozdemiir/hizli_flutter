import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    super.initState();
    authController.isLogin().then((value) => {});
  }
}
