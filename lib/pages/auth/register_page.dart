import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/auth/auth_controller.dart';


class RegisterPage extends StatelessWidget {
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: authController.registerFormKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => Get.back(),
                  ),
                ),
                loginImage(),
                formFields(),
                registerButton(),
                loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  loginImage() {
    return FadedScaleAnimation(
      child: Image.asset(
        'assets/images/account.png',
        height: Get.height * 0.25,
        width: Get.height * 0.25,
      ),
    );
  }

  formFields() {
    return Column(
      children: [
        FadedScaleAnimation(
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Boş olamaz!';
              }
              return null;
            },
            controller: authController.nameRegisterController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Kullanıcı Adı',
              labelText: 'Kullanıcı Adı',
              suffixIcon: Icon(Icons.account_circle),
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
              bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
              if (value.isEmpty) {
                return 'Boş olamaz!';
              }
              else if(!emailValid){
                return 'E-mail adresinizi kontrol ediniz!';
              }
            },
            controller: authController.mailRegisterController,
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
            controller: authController.passwordRegisterController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: 'Şifre',
              labelText: 'Şifre',
              suffixIcon: Icon(Icons.lock),
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
            controller: authController.passwordAgainRegisterController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: 'Şifre Tekrar',
              labelText: 'Şifre Tekrar',
              suffixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  registerButton() {
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
          onPressed: authController.register,
          child: Text(
              'Kayıt Ol',
              style: TextStyle(color: Colors.white),
          ),
        ),
            ),
      ),
    );
  }

  loginButton() {
    return FittedBox(
      child: FadedScaleAnimation(
        child: TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'Giriş Yap',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}


