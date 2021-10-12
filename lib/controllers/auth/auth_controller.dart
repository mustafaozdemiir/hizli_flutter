import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/data/data.dart';
import 'package:hizliflutter/main.dart';
import 'package:hizliflutter/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  Rx<bool> isLogin = false.obs;
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
      var response = await Data.post(
          isSecure: false,
          body: user,
          dataType: DataType.Login,
          isToken: false);

      if (response.statusCode > 400 || response.statusCode < 200) {
        isLoading.value = false;
        //jsonDecode(response.body)['message']
        Get.snackbar('Hata', 'Giriş Başarısız!');
      } else if (200 <= response.statusCode && response.statusCode < 400) {
        user = User.fromJson(jsonDecode(response.body)['user']);
        user.token = jsonDecode(response.body)['token'];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        print(jsonDecode(response.body)['token'].toString() + ' User token');
        await preferences.setString(
            'userLoginToken', jsonDecode(response.body)['token']);
        await preferences.setString('user', jsonEncode(user));
        isLoading.value = false;
        mailLoginController.clear();
        passwordLoginController.clear();
        isLogin.value = true;
        update();

        await Get.offAll(MyHomePage());
        Get.snackbar('Giriş başarılı', 'Hoşgeldiniz ' + user.name);
      }
    }
  }

  Future<void> isLoginFunction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('user') &&
        preferences.containsKey('userLoginToken')) {
      user.value = User.fromJson(jsonDecode(preferences.getString('user')));
      userLoginToken = preferences.getString('userLoginToken');
      isLogin.value = true;
      //await Get.offAll(() => MyHomePage());
    } else {
      isLogin.value = false;
      //await Get.offAll(() => LoginPage());
    }
    update();
  }

  logout() async {
    var response = await Data.post(
        isSecure: false, dataType: DataType.Logout, isToken: true);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('user').then(
          (value) => preferences.remove('userLoginToken').then(
            (value) async {
              isLogin.value = false;
              Get.snackbar('Çıkış başarılı', 'Tekrar Görüşmek Üzere... ');
            },
          ),
        );
    isLoading.value = false;

    update();
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
        var response = await Data.post(
            isSecure: false,
            body: user,
            dataType: DataType.Register,
            isToken: false);
        if (response.statusCode > 400 || response.statusCode < 200) {
          isLoading.value = false;
          //jsonDecode(response.body)['message']
          Get.snackbar('Hata', 'Kayıt Başarısız!');
        } else if (200 <= response.statusCode && response.statusCode < 400) {
          nameRegisterController.clear();
          mailRegisterController.clear();
          passwordRegisterController.clear();
          passwordAgainRegisterController.clear();
          isLoading.value = false;
          Get.back();
          Get.back();
          Get.snackbar('Kayıt başarılı', 'Giriş yapabilirsiniz... ');
        }
      } else {
        Get.snackbar('Hata', 'Şifre ve tekrarı eşleşmiyor.');
      }
    }
  }
}
