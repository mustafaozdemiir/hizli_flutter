import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthController authController = Get.put(AuthController());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: authController.formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                loginImage(),
                formFields(),
                loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginImage() {
    return Image.asset(
      'res/launcher_icon.png',
      height: Get.height * 0.25,
      width: Get.height * 0.25,
    );
  }

  formFields() {
    return Column(
      children: [
        TextFormField(
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
        SizedBox(
          height: 10,
        ),
        TextFormField(
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
      ],
    );
  }

  loginButton() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: authController.isLoading.value
            ? CircularProgressIndicator()
            : TextButton(
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
    );
  }
}
