import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/app_string.dart';
import 'package:hizliflutter/main.dart';
import 'package:hizliflutter/models/user.dart';
import 'package:hizliflutter/pages/auth/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  Rx<User> user;
  var userLoginToken;

  TextEditingController mailLoginController;
  TextEditingController passwordLoginController;
  final loginFormKey = GlobalKey<FormState>();

  TextEditingController nameRegisterController;
  TextEditingController mailRegisterController;
  TextEditingController passwordRegisterController;
  TextEditingController passwordAgainRegisterController;
  final registerFormKey = GlobalKey<FormState>();

  var isLoading = false.obs;

  @override
  void onInit() {
    mailLoginController = TextEditingController();
    passwordLoginController = TextEditingController();
    nameRegisterController = TextEditingController();
    mailRegisterController = TextEditingController();
    passwordRegisterController = TextEditingController();
    passwordAgainRegisterController = TextEditingController();
    user = User().obs;
    userLoginToken = ''.obs;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    mailLoginController.dispose();
    passwordLoginController.dispose();
    nameRegisterController.dispose();
    mailRegisterController.dispose();
    passwordRegisterController.dispose();
    passwordAgainRegisterController.dispose();
  }

  login() async {
    if (loginFormKey.currentState.validate()) {
      isLoading.value = true;
      User user = User();
      user.email = mailLoginController.text;
      user.password = passwordLoginController.text;
      var response = await http.post(
          Uri.parse(AppString.webUrl + AppString.webDataUrl + 'login'),
          body: jsonEncode(user.toJson()),
          headers: AppString.header);
      if (response.statusCode > 400 || response.statusCode < 200) {
        isLoading.value = false;
        Get.snackbar('Hata', jsonDecode(response.body)['message']);
      } else if (200 <= response.statusCode && response.statusCode < 400) {
        user = User.fromJson(jsonDecode(response.body)['user']);
        user.token = jsonDecode(response.body)['token'];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString(
            'userLoginToken', jsonDecode(response.body)['token']);
        await preferences.setString('user', jsonEncode(user));
        print(jsonDecode(response.body)['token']);
        isLoading.value = false;
        mailLoginController.clear();
        passwordLoginController.clear();

        Get.snackbar('Giriş başarılı', 'Hoşgeldiniz ' + user.name);
        await Get.offAll(MyHomePage());
      }
    }
  }

  Future<void> isLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('user') &&
        preferences.containsKey('userLoginToken')) {
      user.value = User.fromJson(jsonDecode(preferences.getString('user')));
      userLoginToken = preferences.getString('userLoginToken');
      await Get.offAll(() => MyHomePage());
    } else {
      await Get.offAll(() => LoginPage());
    }
  }

  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('userLoginToken');
    await preferences.remove('user');
    print(user.value.token);
    var response = await http.post(
        Uri.parse(AppString.webUrl + AppString.webDataUrl + 'logout'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + user.value.token,
        });
    if (response.statusCode > 400 || response.statusCode < 200) {
      isLoading.value = false;
      print(response.body);
      Get.snackbar('Hata', jsonDecode(response.body).toString());
    } else if (200 <= response.statusCode && response.statusCode < 400) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      Get.snackbar('Çıkış Başarılı', jsonDecode(response.body).toString());
      await preferences
          .remove('user')
          .then((value) => preferences.remove('userLoginToken').then(
                (value) => Get.offAll(
                  LoginPage(),
                ),
              ));
      isLoading.value = false;
      Get.snackbar('Çıkış başarılı', 'Tekrar Görüşmek Üzere... ');
    }
  }

  register() async {
    if (registerFormKey.currentState.validate()) {
      if (passwordRegisterController.text ==
          passwordAgainRegisterController.text) {
        isLoading.value = true;
        User user = User();
        user.name = nameRegisterController.text;
        user.email = mailRegisterController.text;
        user.password = passwordRegisterController.text;
        user.passwordAgain = passwordAgainRegisterController.text;
        var response = await http.post(
            Uri.parse(AppString.webUrl + AppString.webDataUrl + 'register'),
            body: jsonEncode(user.toJson()),
            headers: AppString.header);
        if (response.statusCode > 400 || response.statusCode < 200) {
          isLoading.value = false;
          Get.snackbar('Hata', jsonDecode(response.body)['message']);
        } else if (200 <= response.statusCode && response.statusCode < 400) {
          nameRegisterController.clear();
          mailRegisterController.clear();
          passwordRegisterController.clear();
          passwordAgainRegisterController.clear();
          isLoading.value = false;
          Get.snackbar('Kayıt başarılı', 'Giriş yapabilirsiniz... ');
          Get.back();
          Get.back();
        }
      } else {
        Get.snackbar('Hata', 'Şifre ve tekrarı eşleşmiyor.');
      }
    }
  }
}
