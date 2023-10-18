import 'package:fashion_app/app/modules/home/home_controller.dart';
import 'package:fashion_app/app/modules/login/login_controller.dart';
import 'package:get/get.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(), permanent: true);
  }
}
