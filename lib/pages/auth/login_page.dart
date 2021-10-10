import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/controllers/auth/auth_controller.dart';

import 'register_page.dart';

class LoginPage extends StatelessWidget {
  AuthController authController = Get.put(AuthController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: ShapeDecoration(
          color: Colors.white38,
          shape: RoundedRectangleBorder(side: BorderSide.none),
        ),
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              loginImage(),
              formFields(),
              loginButton(),
              registerButton(),
            ],
          ),
        ),
      ),
    );
  }
  loginImage() {
    return FadedScaleAnimation(
      child: Image.asset(
        'res/launcher_icon.png',
        height: Get.height * 0.25,
        width: Get.height * 0.25,
      ),
    );
  }

  formFields() {
    return Form(key: authController.loginFormKey,
      child: Column(
        children: [
          FadedScaleAnimation(
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Boş olamaz!';
                }
                return null;
              },
              controller: authController.mailLoginController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'E-mail',
                labelText: 'E-mail',
                suffixIcon: Icon(Icons.mail),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FadedScaleAnimation(
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Boş olamaz!';
                }
                return null;
              },
              obscureText: true,
              controller: authController.passwordLoginController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: 'Şifre',
                labelText: 'Şifre',
                suffixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  loginButton() {
    return Obx(
          () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: authController.isLoading.value
            ? CircularProgressIndicator()
            : FadedScaleAnimation(
              child: TextButton(
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(
                Size(Get.width * 0.95, 50),
              ),
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: authController.login,
          child: Text(
              'Giriş',
              style: TextStyle(color: Colors.white),
          ),
        ),
            ),
      ),
    );
  }

  registerButton() {
    return FadedScaleAnimation(
      child: TextButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(
            Size(Get.width * 0.95, 50),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        onPressed: () => Get.to(RegisterPage()),
        child: Text(
          'Kayıt Ol',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

