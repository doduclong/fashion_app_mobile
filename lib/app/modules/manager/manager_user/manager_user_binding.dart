import 'package:fashion_app/app/modules/manager/manager_user/manager_user_controller.dart';
import 'package:get/get.dart';

class ManagerUserBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ManagerUserController());
  }
}