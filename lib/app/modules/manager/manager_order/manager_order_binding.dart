import 'package:fashion_app/app/modules/manager/manager_order/manager_order_controller.dart';
import 'package:get/get.dart';

class ManagerOrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ManagerOrderController());
  }
}