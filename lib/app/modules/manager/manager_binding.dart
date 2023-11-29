import 'package:fashion_app/app/modules/manager/manager_controller.dart';
import 'package:get/get.dart';

class ManagerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ManagerController());
  }
}