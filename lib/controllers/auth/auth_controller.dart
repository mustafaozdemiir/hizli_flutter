import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/data/data.dart';
import 'package:hizliflutter/main.dart';
import 'package:hizliflutter/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  RxBool isLogin = false.obs;
  Rx<User>? user;
  RxString userLoginToken = ''.obs;

  late final TextEditingController mailLoginController;
  late final TextEditingController passwordLoginController;
  final loginFormKey = GlobalKey<FormState>();

  late final TextEditingController nameRegisterController;
  late final TextEditingController mailRegisterController;
  late final TextEditingController passwordRegisterController;
  late final TextEditingController passwordAgainRegisterController;
  final registerFormKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    mailLoginController = TextEditingController();
    passwordLoginController = TextEditingController();
    nameRegisterController = TextEditingController();
    mailRegisterController = TextEditingController();
    passwordRegisterController = TextEditingController();
    passwordAgainRegisterController = TextEditingController();
    user = Rx<User>(User());
    super.onInit();
  }

  @override
  void dispose() {
    mailLoginController.dispose();
    passwordLoginController.dispose();
    nameRegisterController.dispose();
    mailRegisterController.dispose();
    passwordRegisterController.dispose();
    passwordAgainRegisterController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (loginFormKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      User user = User(
        email: mailLoginController.text,
        password: passwordLoginController.text,
      );
      var response = await Data.post(
        isSecure: false,
        body: user,
        dataType: DataType.Login,
        isToken: false,
      );

      if (response?.statusCode == null || response!.statusCode >= 400) {
        isLoading.value = false;
        Get.snackbar('Hata', 'Giriş Başarısız!');
      } else if (response.statusCode < 400) {
        var responseBody = jsonDecode(response.body);
        user = User.fromJson(responseBody['user']);
        user.token = responseBody['token'];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString('userLoginToken', responseBody['token']);
        await preferences.setString('user', jsonEncode(user));
        isLoading.value = false;
        mailLoginController.clear();
        passwordLoginController.clear();
        isLogin.value = true;
        update();
        await Get.offAll(() => MyHomePage());
        Get.snackbar('Giriş başarılı', 'Hoşgeldiniz ${user.name}');
      }
    }
  }

  Future<void> isLoginFunction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('user') && preferences.containsKey('userLoginToken')) {
      user!.value = User.fromJson(jsonDecode(preferences.getString('user')!));
      userLoginToken.value = preferences.getString('userLoginToken')!;
      isLogin.value = true;
    } else {
      isLogin.value = false;
    }
    update();
  }

  Future<void> logout() async {
    var response = await Data.post(
      isSecure: false,
      dataType: DataType.Logout,
      isToken: true,
    );

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('user');
    await preferences.remove('userLoginToken');
    isLogin.value = false;
    Get.snackbar('Çıkış başarılı', 'Tekrar Görüşmek Üzere...');
    isLoading.value = false;
    update();
  }

  Future<void> register() async {
    if (registerFormKey.currentState?.validate() ?? false) {
      if (passwordRegisterController.text == passwordAgainRegisterController.text) {
        isLoading.value = true;
        User user = User(
          name: nameRegisterController.text,
          email: mailRegisterController.text,
          password: passwordRegisterController.text,
          passwordAgain: passwordAgainRegisterController.text,
        );
        var response = await Data.post(
          isSecure: false,
          body: user,
          dataType: DataType.Register,
          isToken: false,
        );

        if (response?.statusCode == null || response!.statusCode >= 400) {
          isLoading.value = false;
          Get.snackbar('Hata', 'Kayıt Başarısız!');
        } else if (response.statusCode < 400) {
          nameRegisterController.clear();
          mailRegisterController.clear();
          passwordRegisterController.clear();
          passwordAgainRegisterController.clear();
          isLoading.value = false;
          Get.back();
          Get.back();
          Get.snackbar('Kayıt başarılı', 'Giriş yapabilirsiniz...');
        }
      } else {
        Get.snackbar('Hata', 'Şifre ve tekrarı eşleşmiyor.');
      }
    }
  }
}
