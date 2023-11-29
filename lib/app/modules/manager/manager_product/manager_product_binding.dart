import 'package:fashion_app/app/modules/manager/manager_product/manager_product_controller.dart';
import 'package:get/get.dart';

class ManagerProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ManagerProductController());
  }
}