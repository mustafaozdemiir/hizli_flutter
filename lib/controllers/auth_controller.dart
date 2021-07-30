import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/app_string.dart';
import 'package:hizliflutter/controllers/user_controller.dart';
import 'package:hizliflutter/main.dart';
import 'package:hizliflutter/models/user.dart';
import 'package:hizliflutter/pages/auth/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  UserController userController = Get.put(UserController());

  TextEditingController mailLoginController;
  TextEditingController passwordLoginController;
  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;

  @override
  void onInit() {
    mailLoginController = TextEditingController();
    passwordLoginController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    mailLoginController.dispose();
    passwordLoginController.dispose();
  }

  login() async {
    if (formKey.currentState.validate()) {
      isLoading.value = true;
      User user = User();
      user.email = mailLoginController.text;
      user.password = passwordLoginController.text;
      var response = await http.post(
          'http://api.hizliflutter.yazilimmotoru.com/api/login',
          body: jsonEncode(user.toJson()),
          headers: AppString.header);
      print(response.body);
      if (response.statusCode > 400 || response.statusCode < 200) {
        isLoading.value = false;
        Get.snackbar('Hata', jsonDecode(response.body)['message']);
      } else if (200 <= response.statusCode && response.statusCode < 400) {
        userController.user = User.fromJson(jsonDecode(response.body)['user']);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString(
            'userLoginToken', jsonDecode(response.body)['token']);
        await preferences.setString('user', jsonEncode(userController.user));

        isLoading.value = false;

        Get.snackbar(
            'Giriş başarılı', 'Hoşgeldiniz ' + userController.user.name);
        await Get.offAll(MyHomePage());
      }
    }
  }

  Future<void> isLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('user') &&
        preferences.containsKey('userLoginToken')) {
      userController.user =
          User.fromJson(jsonDecode(preferences.getString('user')));
      userController.userLoginToken = preferences.getString('userLoginToken');
      await Get.offAll(MyHomePage());
    } else {
      await Get.offAll(LoginPage());
    }
  }

  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences
        .remove('user')
        .then((value) => preferences.remove('userLoginToken').then(
              (value) => Get.offAll(
                LoginPage(),
              ),
            ));
  }
}
