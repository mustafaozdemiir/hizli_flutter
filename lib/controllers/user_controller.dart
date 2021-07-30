import 'package:get/get.dart';
import 'package:hizliflutter/models/user.dart';

class UserController extends GetxController {
  var user;
  var userLoginToken;

  @override
  void onInit() {
    user = User().obs;
    userLoginToken = ''.obs;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
